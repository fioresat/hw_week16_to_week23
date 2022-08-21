import 'objectbox.g.dart';
import 'order.dart';


class OrdersRepository {
  late final Store _store;
  late final Box<OrderEntity> _box;

  List<OrderEntity> get orders => _box.getAll();

  Future initDB() async {
    _store = await openStore();
    _box = _store.box<OrderEntity>();
  }

  Future addNote(OrderEntity order) async {
    await _box.putAsync(order);
  }
}