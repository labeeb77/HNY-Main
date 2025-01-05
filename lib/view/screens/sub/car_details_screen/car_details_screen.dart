import 'package:flutter/material.dart';
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
          children: const [
            CarHeader(),
            CarSpecs(),
            CarFeatures(),
            LocationDetails(),
            BookingDetails(),
            BookingPrice(),
          ],
        ),
      ),
    );
  }
}