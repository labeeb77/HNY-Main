import 'package:hny_main/data/models/booking/add_on_list_model.dart';

class GadgetModel {
  final String id;
  final String name;
  final double price;
  final double weeklyPrice;
  final double monthlyPrice;
  final String image;
  final bool isQuantityItem;
  int quantity;
  String? cartItemId;
  
  // Adding the new pricing fields
  int? pricePerDay;
  int? pricePerWeek;
  int? pricePerMonth;
  
  GadgetModel({
    required this.id,
    required this.name,
    required this.price,
    required this.weeklyPrice,
    required this.monthlyPrice,
    required this.image,
    required this.isQuantityItem,
    this.quantity = 0,
    this.cartItemId,
    this.pricePerDay,
    this.pricePerWeek,
    this.pricePerMonth,
  });
  
  // You could also add a factory constructor to create a GadgetModel from an AddOnArrList
  factory GadgetModel.fromAddOnArrList(AddOnArrList addOn) {
    return GadgetModel(
      id: addOn.id ?? '',
      name: addOn.strName ?? '',
      price: (addOn.intPricePerDay ?? 0).toDouble(), // Default to day price
      weeklyPrice: (addOn.intPricePerWeek ?? 0).toDouble(),
      monthlyPrice: (addOn.intPricePerMonth ?? 0).toDouble(),
      image: addOn.strImageUrl ?? '',
      pricePerDay: addOn.intPricePerDay,
      pricePerWeek: addOn.intPricePerWeek,
      pricePerMonth: addOn.intPricePerMonth,
      isQuantityItem: false,
    );
  }
}