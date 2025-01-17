import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';

class CommonBackButton extends StatelessWidget {
  final showBorder;
  const CommonBackButton({
    this.showBorder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          
         decoration: BoxDecoration(shape: BoxShape.circle,color:  AppColors.white,border:showBorder?  Border.all(color: const Color(0xFFF0F0F0)):null),
            child: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
    );
  }
}
