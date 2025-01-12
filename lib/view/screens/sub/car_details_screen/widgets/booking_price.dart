import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/add_gadget_bottomsheet.dart';
import 'package:hny_main/view/widgets/app_button.dart';

class BookingPrice extends StatelessWidget {
  final title;
  final value;
  final buttonName;
  final onTap;
  const BookingPrice(
      {Key? key, this.title, this.value, this.buttonName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: AppColors.containerBorderColor))),
      padding: const EdgeInsets.only(bottom: 24, left: 19, right: 19, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'AED $value',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          PrimaryElevateButton(ontap: onTap, buttonName: buttonName)
        ],
      ),
    );
  }
}
