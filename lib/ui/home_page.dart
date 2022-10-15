import 'package:flutter/material.dart';
import '../di/config.dart';
import '../domain/model/order_model.dart';
import 'orders_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = getIt<OrdersStore>();

  final bool _sortAscending = true;
  final int _sortColumnIndex = 0;

  @override
  void initState() {
    super.initState();
    _viewModel.initStore().whenComplete(() => _viewModel.getData());
  //  _viewModel.getData();
    // _ordersRepo
    //     .initDB()
    //     .whenComplete(() => setState(() => _orders = _ordersRepo.orders));
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
      body: Observer(builder: (_){
        return SingleChildScrollView(
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
              rows: List<DataRow>.generate(
                  _viewModel.value.length,
                      (int index) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(_viewModel.value[index].name),
                    ),
                    DataCell(
                      Text(
                        '\$${_viewModel.value[index].price}',
                      ),
                    ),
                    DataCell(
                      const Icon(Icons.delete),
                      onTap: () async {
                        await _viewModel.removeOrder(_viewModel.value[index]);
                        _viewModel.getData();
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      }),
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
                await _viewModel.addOrder(
                  OrderModel.create(
                    name: nameController.text,
                    price: priceController.text,
                  ),
                );
                _viewModel.getData();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }
}
