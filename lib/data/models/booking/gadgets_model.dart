class GadgetModel {
  final String id;
  final String name;
  final double price;
  final String image;
  bool isQuantityItem;
  int quantity;

  GadgetModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.isQuantityItem = false,
    this.quantity = 0,
  });
}