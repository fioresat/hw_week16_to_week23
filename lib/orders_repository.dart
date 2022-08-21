import 'objectbox.g.dart';
import 'order.dart';
import 'dart:async';

class OrdersRepository {
  late final Store _store;
  late final Box<OrderEntity> _box;

  List<OrderEntity> get orders => _box.getAll();

  Future initDB() async {
    _store = await openStore();
    _box = _store.box<OrderEntity>();
  }

  Future addOrder(OrderEntity order) async {
    await _box.putAsync(order);
  }

  Future removeOrder(OrderEntity order) async {
    await _box.remove(order.id);
  }

  Future updateOrder(OrderEntity order1, OrderEntity order2) async {
    await _box.remove(order1.id);
    await _box.putAsync(order2);
  }
}
