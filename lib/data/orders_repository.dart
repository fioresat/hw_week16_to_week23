import 'package:hw_week16_database/data/mapper/domain_to_dto.dart';
import 'package:hw_week16_database/data/mapper/dto_to_domain.dart';
import '../domain/model/order_model.dart';
import '../objectbox.g.dart';
import 'order_entity.dart';
import 'dart:async';
import 'package:injectable/injectable.dart';

@lazySingleton
class OrdersRepository {
  late final Store _store;
  late final Box<OrderEntity> _box;

  List<OrderModel> get orders => _box.getAll().map((e) => e.toDomain()).toList();

  Future initDB() async {
    _store = await openStore();
    _box = _store.box<OrderEntity>();
  }

  Future addOrder(OrderModel order) async {
    await _box.putAsync(order.toEntity());
  }

  Future removeOrder(OrderModel order) async {
    await _box.remove(order.id);
  }

}
