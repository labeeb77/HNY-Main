import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:provider/provider.dart';

class CarHeader extends StatelessWidget {
  final ArrCar arrCar;
  const CarHeader({super.key, required this.arrCar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
          arrCar.strImgUrl != null && arrCar.strImgUrl!.isNotEmpty
    ? Image.network(
        arrCar.strImgUrl!,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      )
    : Image.asset(
        'assets/images/placeholder_image.webp',
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
            _buildHeaderIcons(context),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCarType(),
              const SizedBox(height: 8),
              _buildCarTitle(),
              const SizedBox(height: 8),
              _buildCarDescription(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarType() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            arrCar.strCarCategory ?? 'N/A',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${arrCar.strBrand} ${arrCar.strModel}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE4E4E4)),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              Text(
                ' ${arrCar.intRating?.toStringAsFixed(1) ?? 'N/A'}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCarDescription() {
    return Text(
      arrCar.strDescription ?? 'No description available',
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildHeaderIcons(BuildContext context) {
    // This remains the same as your original implementation
    return Positioned(
      top: 40,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircledIcon(
              ontap: () => Navigator.pop(context),
              circleColor: AppColors.circleAvatarBackground,
              iconColor: AppColors.white,
              icon: Icons.arrow_back,
            ),
            Row(
              children: [
                CircledIcon(
                  circleColor: AppColors.circleAvatarBackground,
                  iconColor: AppColors.white,
                  icon: Icons.share,
                ),
                const Gap(12),
                CircledIcon(
                  circleColor: AppColors.circleAvatarBackground,
                  iconColor: AppColors.white,
                  icon: Icons.favorite_border,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
