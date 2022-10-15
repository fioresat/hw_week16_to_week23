import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../domain/interactor/orders_interactor.dart';
import '../domain/model/order_model.dart';
import 'package:injectable/injectable.dart';

part 'orders_store.g.dart'; // Указание для кодогенерации

@injectable
class OrdersStore = _OrdersStore with _$OrdersStore;

abstract class _OrdersStore with Store {
  final OrdersInteractor _ordersInteractor;

  @observable
  List<OrderModel> value = [];

  _OrdersStore(this._ordersInteractor);

  Future initStore() async{
  await _ordersInteractor.init();
}

  @action
  Future getData() async {
    value = _ordersInteractor.orders;
  }

  Future addOrder(OrderModel order) => _ordersInteractor.addOrder(order);

  Future removeOrder(OrderModel order) => _ordersInteractor.removeOrder(order);
}

