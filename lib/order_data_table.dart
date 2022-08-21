import 'package:flutter/material.dart';

import 'orders_repository.dart';

class OrderDataTable extends StatefulWidget {
  final void Function(int columnIndex, bool ascending) onSort;

  const OrderDataTable({
    Key? key,
    required this.onSort,
  }) : super(key: key);

  @override
  _OrderDataTableState createState() => _OrderDataTableState();
}

class _OrderDataTableState extends State<OrderDataTable> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;
  final _ordersRepo = OrdersRepository();
  late var _orders = _ordersRepo.orders;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Text('Number'),
              onSort: _onDataColumnSort,
            ),
            DataColumn(
              label: Text('Customer'),
            ),
            DataColumn(
              label: Text('Price'),
              numeric: true,
              onSort: _onDataColumnSort,
            ),
            DataColumn(
              label: Container(),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Text('_orders[0].ID'),
                ),
                DataCell(
                  Text('_orders[0].name'),
                  onTap: () {
                    // TODO: Show only tapped customer's orders in a modal bottom sheet
                  },
                ),
                DataCell(
                  Text(
                    '_orders[0].price',
                  ),
                ),
                DataCell(
                  Icon(Icons.delete),
                  onTap: () {
                    // TODO: Delete the order from the database
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onDataColumnSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
    widget.onSort(columnIndex, ascending);
  }
}