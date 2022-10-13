import 'package:objectbox/objectbox.dart';

@Entity()
class OrderEntity {
  @Id()
  int id;
  String name;
  String price;

  OrderEntity({
    this.id = 0,
    required this.name,
    required this.price,
  });
}
