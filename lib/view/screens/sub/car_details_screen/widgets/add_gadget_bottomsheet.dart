import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/checkout_screen.dart';
import 'package:hny_main/view/widgets/app_button.dart';

class GadgetModel {
  final String name;
  final double price;
  final String image;
  bool isQuantityItem;
  int quantity;

  GadgetModel({
    required this.name,
    required this.price,
    required this.image,
    this.isQuantityItem = false,
    this.quantity = 0,
  });
}

class GadgetBottomSheet extends StatefulWidget {
  const GadgetBottomSheet({super.key});

  @override
  State<GadgetBottomSheet> createState() => _GadgetBottomSheetState();
}

class _GadgetBottomSheetState extends State<GadgetBottomSheet> {
  final List<GadgetModel> gadgets = [
    GadgetModel(name: 'Child seat', price: 20, image: 'assets/child_seat.png'),
    GadgetModel(name: 'iPhone Charger', price: 10, image: 'assets/charger.png'),
    GadgetModel(name: 'Power Bank', price: 15, image: 'assets/power_bank.png'),
    GadgetModel(name: 'GPS Navigator', price: 25, image: 'assets/gps.png'),
    GadgetModel(name: 'Dash Cam', price: 30, image: 'assets/dash_cam.png'),
    GadgetModel(
      name: 'Phone Holder',
      price: 8,
      image: 'assets/phone_holder.png',
      isQuantityItem: true,
    ),
    GadgetModel(
      name: 'Bluetooth Speaker',
      price: 35,
      image: 'assets/bluetooth_speaker.png',
      isQuantityItem: true,
    ),
  ];

  double get totalPrice {
    return gadgets.fold(
      0,
      (sum, gadget) => sum + (gadget.quantity * gadget.price),
    );
  }

  int get totalItems {
    return gadgets.fold(
      0,
      (sum, gadget) => sum + gadget.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Add Your Gadget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gadgets.length,
              itemBuilder: (context, index) {
                final gadget = gadgets[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.containerBorderColor),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/placeholder_image.webp"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gadget.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${gadget.price.toStringAsFixed(0)} AED',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (gadget.isQuantityItem)
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: gadget.quantity > 0
                                  ? () {
                                      setState(() {
                                        gadget.quantity--;
                                      });
                                    }
                                  : null,
                            ),
                            Text('${gadget.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  gadget.quantity++;
                                });
                              },
                            ),
                          ],
                        )
                      else
                        PrimaryElevateButton(
                          buttonName: "Add",
                          ontap: () {},
                          isGrey: true,
                        )
                    ],
                  ),
                );
              },
            ),
          ),
          BookingPrice(
            title: "$totalItems Add-On",
            value: totalPrice.toString(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            buttonName: "Continue",
          )
        ],
      ),
    );
  }
}
