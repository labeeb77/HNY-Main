import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/add_gadget_bottomsheet.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_details.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_feature.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_header.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_specs.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/location_details.dart';

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
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BookingPrice(
          title: "Total Amount",
          value: arrCar.intPricePerDay ?? 0,
          onTap: () {
            showModalBottomSheet(
              showDragHandle: true,
              enableDrag: true,
              context: context,
              isScrollControlled: true,
              builder: (context) => const GadgetBottomSheet(),
            );
          },
          buttonName: "Book Now",
        ),
      ),
    );
  }
}