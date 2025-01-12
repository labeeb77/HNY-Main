import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';





class PrimaryElevateButton extends StatelessWidget {
  final buttonName;
  final isGrey;
  final ontap;
  const PrimaryElevateButton({
    this.ontap,
    this.buttonName,this.isGrey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed:ontap??(){},
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor:isGrey!=null? AppColors.greenShadeBackground :AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child:  FittedBox(child: AppText(buttonName??"Book Now",color:isGrey!=null?AppColors.primary: AppColors.white,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),maxLines: 1,)),
      ),
    );
  }
}

/// secondary button

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const AppButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.borderRadius = 25.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? theme.colorScheme.primary, // Default to theme primary color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
