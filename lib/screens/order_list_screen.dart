import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../services/order_provider.dart';
import 'add_order_screen.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {

  String search = "";
  String selectedStatus = "All";

  String nextStatus(String current) {
    if (current == "Received") return "Washing";
    if (current == "Washing") return "Ready";
    if (current == "Ready") return "Delivered";
    return "Delivered";
  }

  Color statusColor(String status) {
    switch (status) {
      case "Received":
        return Colors.orange;
      case "Washing":
        return Colors.blue;
      case "Ready":
        return Colors.purple;
      case "Delivered":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void goToAdd() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddOrderScreen()),
    );

    Provider.of<OrderProvider>(context, listen: false).loadOrders();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<OrderProvider>(context, listen: false).loadOrders();
    });
  }

  // ✅ DASHBOARD
  Widget buildDashboard(List<Order> orders) {
    int totalOrders = orders.length;

    double totalRevenue = 0;
    for (var o in orders) {
      totalRevenue += o.total;
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text("Orders"),
                  SizedBox(height: 5),
                  Text(
                    "$totalOrders",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text("Revenue"),
                  SizedBox(height: 5),
                  Text(
                    "${totalRevenue.toStringAsFixed(2)} KD",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList() {
    var orderProvider = Provider.of<OrderProvider>(context);
    List<Order> orders = orderProvider.orders;

    final query = search.trim().toLowerCase();

    List<Order> filtered = orders;

    // ✅ STATUS FILTER
    if (selectedStatus != "All") {
      filtered = filtered.where((o) => o.status == selectedStatus).toList();
    }

    // ✅ SEARCH FILTER
    if (query.isNotEmpty) {
      filtered = filtered.where((o) {
        return o.name.toLowerCase().contains(query) ||
               o.orderId.toLowerCase().contains(query);
      }).toList();
    }

    if (filtered.isEmpty) {
      return Center(child: Text("No Orders Found"));
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        var order = filtered[index];

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          elevation: 3,
          child: ListTile(
            contentPadding: EdgeInsets.all(10),

            title: Text(
              "${order.orderId} - ${order.name}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text("📞 ${order.phone}"),
                Text("🧺 ${order.service}"),
                Text(
                  "Status: ${order.status}",
                  style: TextStyle(
                    color: statusColor(order.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("💰 ${order.total.toStringAsFixed(2)} KD"),
              ],
            ),

            trailing: order.status == "Delivered"
			? SizedBox()
			: ElevatedButton(
				child: Text("Next"),
				onPressed: () {
				order.status = nextStatus(order.status);
				Provider.of<OrderProvider>(context, listen: false)
					.updateOrder(order);
				},
			),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    var orders = Provider.of<OrderProvider>(context).orders;

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: goToAdd,
        child: Icon(Icons.add),
      ),

      body: Column(
        children: [

          // ✅ DASHBOARD
          buildDashboard(orders),

          // ✅ FILTER
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["All", "Received", "Washing", "Ready", "Delivered"]
                  .map((status) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(status),
                    selected: selectedStatus == status,
                    onSelected: (_) {
                      setState(() {
                        selectedStatus = status;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 10),

          // ✅ SEARCH
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search by Name or Order ID",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
            ),
          ),

          // ✅ LIST
          Expanded(
            child: buildList(),
          )
        ],
      ),
    );
  }
}