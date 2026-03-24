import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../services/order_provider.dart';

class AddOrderScreen extends StatefulWidget {
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final itemsController = TextEditingController();
  final priceController = TextEditingController();

  String service = "Wash";

  Future<void> saveOrder() async {

    // ✅ Validation
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        itemsController.text.isEmpty ||
        priceController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    int items = int.tryParse(itemsController.text) ?? 0;
    double price = double.tryParse(priceController.text) ?? 0;

    if (items <= 0 || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid numbers")),
      );
      return;
    }

    double total = items * price;

    String orderId = "ORD${DateTime.now().millisecondsSinceEpoch}";

    // ✅ Save to DB using Provider
    await Provider.of<OrderProvider>(context, listen: false).addOrder(
      Order(
        id: 0,
        orderId: orderId,
        name: nameController.text,
        phone: phoneController.text,
        service: service,
        items: items,
        price: price,
        total: total,
        status: "Received",
      ),
    );

    // ✅ Success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order Saved Successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Order"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [

              // Customer Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),

              // Phone
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone No.',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 12),

              // Service Type
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Service Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  value: service,
                  isExpanded: true,
                  underline: SizedBox(),
                  items: ["Wash", "Dry Clean"].map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      service = val!;
                    });
                  },
                ),
              ),
              SizedBox(height: 12),

              // Items
              TextField(
                controller: itemsController,
                decoration: InputDecoration(
                  labelText: 'Number of Items',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),

              // Price
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price per Item',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: saveOrder,
                  child: Text(
                    "Save Order",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}