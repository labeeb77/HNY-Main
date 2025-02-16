import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/add_gadget_bottomsheet.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_details.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_feature.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_header.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_specs.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/location_details.dart';
import 'package:provider/provider.dart';

class CarDetailsScreen extends StatelessWidget {
  final ArrCar arrCar;
  const CarDetailsScreen({super.key, required this.arrCar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarHeader(arrCar: arrCar),
            CarSpecs(arrCar: arrCar),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CarFeatures(features: arrCar.arrCarFeatures),
            ),
            const Divider(),
            const LocationDetails(),
            const DateTimeSelection(),
            const Gap(62),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          final totalAmount = bookingProvider.calculateTotalAmount(arrCar.intPricePerDay ?? 0);
          return SizedBox(
            height: 100,
            child: BookingPrice(
              title: "Total Amount",
              value: totalAmount,
              onTap: bookingProvider.isLoading 
                ? null  // Disable button while loading
                : () async {
                    // First, create cart and show loader in button
                    final success = await bookingProvider.createCart(context, arrCar);
                    
                    // Only show the bottom sheet if cart creation was successful
                    if (success) {
                      await showModalBottomSheet(
                        showDragHandle: true,
                        enableDrag: true,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => GadgetBottomSheet(arrCar: arrCar),
                      );
                    }
                  },
              buttonName: bookingProvider.isLoading ? "Creating cart..." : "Book Now",
            ),
          );
        },
      ),
    );
  }
}