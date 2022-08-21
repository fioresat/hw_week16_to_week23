import 'package:flutter/material.dart';
import 'order.dart';
import 'order_data_table.dart';

import 'orders_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ordersRepo = OrdersRepository();
  late var _orders = _ordersRepo.orders;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders App'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add_alt),
            onPressed: addOrderForCurrentCustomer,
          ),
        ],
      ),
      body: OrderDataTable(
        // TODO: Pass in the orders
        onSort: (columnIndex, ascending) {
          // TODO: Query the database and sort the data
        },
      ),
    );
  }

  Future<Object?> addOrderForCurrentCustomer() {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) {
        final nameController = TextEditingController();
        final priceController = TextEditingController();
        return AlertDialog(
          title: const Text('New order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(hintText: 'Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _ordersRepo.addNote(
                  OrderEntity(
                    name: nameController.text,
                    price: priceController.text,
                  ),
                );
                setState(() {
                  _orders = _ordersRepo.orders;
                  Navigator.pop(context);
                });
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }
}

