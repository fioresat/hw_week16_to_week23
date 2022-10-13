class OrderModel {
  final int id;
  final String name;
  final String price;

  OrderModel({
    required this.id,
    required this.name,
    required this.price,
  });

  OrderModel.create({
    this.id = 0,
    required this.name,
    required this.price,
  });
}