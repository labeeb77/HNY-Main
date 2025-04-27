import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/checkout_screen.dart';
import 'package:hny_main/view/widgets/app_secondary_button.dart';
import 'package:provider/provider.dart';

class GadgetBottomSheet extends StatefulWidget {
  final ArrCar arrCar;

  const GadgetBottomSheet({super.key, required this.arrCar});

  @override
  State<GadgetBottomSheet> createState() => _GadgetBottomSheetState();
}

class _GadgetBottomSheetState extends State<GadgetBottomSheet> {
  @override
  initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookingProvider>(context, listen: false)
          .getAddOnList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
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
              if (bookingProvider.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator())
                )
              else if (bookingProvider.error != null)
                const Expanded(
                  child: Center(child: Text('Error loading gadgets'))
                )
              else if (bookingProvider.gadgets.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No Add-ons Available',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'There are currently no add-ons available for this vehicle.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: bookingProvider.gadgets.length,
                    itemBuilder: (context, index) {
                      final gadget = bookingProvider.gadgets[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.containerBorderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                                image: DecorationImage(
                                  image: NetworkImage(gadget.image),
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
                            if (gadget.quantity > 0)
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      bookingProvider.updateGadgetQuantity(
                                        gadget.id,
                                        gadget.quantity - 1,
                                      );
                                    },
                                  ),
                                  Text('${gadget.quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      bookingProvider.updateGadgetQuantity(
                                        gadget.id,
                                        gadget.quantity + 1,
                                      );
                                    },
                                  ),
                                ],
                              )
                            else
                              SecondaryButton(
                                text: 'Add',
                                onTap: () {
                                  bookingProvider.updateGadgetQuantity(
                                    gadget.id,
                                    gadget.quantity + 1,
                                  );
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: BookingPrice(
                  title: "${bookingProvider.totalGadgetItems} Add-On",
                  value: bookingProvider.totalGadgetPrice.toStringAsFixed(1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreen(
                                arrCar: widget.arrCar,
                              )),
                    );
                  },
                  buttonName: "Continue",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
