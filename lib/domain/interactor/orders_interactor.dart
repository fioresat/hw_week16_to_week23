
import '../../data/orders_repository.dart';
import '../model/order_model.dart';

@injectable
class OrdersInteractor {
  final OrdersRepository _repository;

  OrdersInteractor(this._repository);

  List<OrderModel> get orders => _repository.orders;

  Future init() => _repository.initDB();

  // CREATE
  Future addOrder(OrderModel order) => _repository.addOrder(order);

  Future removeOrder(OrderModel order) => _repository.removeOrder(order);


}