import 'package:flutter/material.dart';
import 'order.dart';

import 'orders_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ordersRepo = OrdersRepository();
  late var _orders = _ordersRepo.orders;
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  @override
  void initState() {
    super.initState();
    _ordersRepo
        .initDB()
        .whenComplete(() => setState(() => _orders = _ordersRepo.orders));
  }

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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              const DataColumn(
                label: Text('Customer'),
              ),
              const DataColumn(
                label: Text('Price'),
                numeric: true,
              ),
              DataColumn(
                label: Container(),
              ),
            ],
            rows: _orders.map((order) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(order.name),
                    onTap: () {
                      updateOrderForCurrentCustomer(order);
                      setState(() {
                        _orders = _ordersRepo.orders;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      '\$${order.price}',
                    ),
                  ),
                  DataCell(
                    Icon(Icons.delete),
                    onTap: () async {
                      await _ordersRepo.removeOrder(order);
                      setState(() {
                        _orders = _ordersRepo.orders;
                      });
                    },
                  ),
                ],
              );
            }).toList(),
          ),
        ),
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
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _ordersRepo.addOrder(
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

  Future<Object?> updateOrderForCurrentCustomer(OrderEntity order) {
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
                decoration: InputDecoration(hintText: order.name),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(hintText: order.price),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _ordersRepo.updateOrder(
                  order,
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
