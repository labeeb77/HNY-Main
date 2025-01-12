import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/add_gadget_bottomsheet.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_details.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_feature.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_header.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/car_specs.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/location_details.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CarHeader(),
            const CarSpecs(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CarFeatures(),
            ),
            const Divider(),
            const LocationDetails(),
            const BookingDetails(),
            const Gap(62),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 100,
          child: BookingPrice(
            title: "Total Amount",
            value: 1933,
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
          )),
    );
  }
}
