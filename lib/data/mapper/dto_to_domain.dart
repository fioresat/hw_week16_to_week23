import '../../domain/model/order_model.dart';
import '../order_entity.dart';

extension OrderEntityToOrderModel on OrderEntity {
  OrderModel toDomain() => OrderModel(id: id, name: name, price: price);
}