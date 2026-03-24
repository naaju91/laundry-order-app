import 'package:flutter/material.dart';
import 'screens/order_list_screen.dart';
import 'package:provider/provider.dart';
import 'services/order_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			providers: [
				ChangeNotifierProvider(create: (_) => OrderProvider()),
			],
			child: MaterialApp(
				title: 'Laundry App',
				home: OrderListScreen(),
			),
		);
	}
}
