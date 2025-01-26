import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:provider/provider.dart';

class CarHeader extends StatelessWidget {
  const CarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              Provider.of<HomeController>(context,listen: false).carListData[0].strImgUrl!,
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
              _buildCarTitle(context),
              const SizedBox(height: 8),
              _buildCarDescription(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderIcons(BuildContext context) {
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

  Widget _buildCarType() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            'Electric',
            style: TextStyle(
                color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildCarTitle(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Ford Escape',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E4E4)),
              borderRadius: BorderRadius.circular(9)),
          child: const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              Text(
                ' 4.8',
                style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCarDescription() {
    return const Text(
      'Experience the comfort and versatility of the Ford Escape – a compact SUV with advanced safety, spacious interiors, and smart tech for every journey.',
      style: TextStyle(color: Colors.grey),
    );
  }
}
