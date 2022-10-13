import '../../domain/model/order_model.dart';
import '../order_entity.dart';

extension OrderModelToOrderEntity on OrderModel {
  OrderEntity toEntity() => OrderEntity(name: name, price:price);
}