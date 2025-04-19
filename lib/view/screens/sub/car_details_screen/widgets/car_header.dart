import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarHeader extends StatefulWidget {
  final ArrCar arrCar;
  const CarHeader({super.key, required this.arrCar});

  @override
  State<CarHeader> createState() => _CarHeaderState();
}

class _CarHeaderState extends State<CarHeader> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            if (widget.arrCar.arrImgUrl != null && widget.arrCar.arrImgUrl!.isNotEmpty)
              Column(
                children: [
                  CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: widget.arrCar.arrImgUrl!.length,
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Image.network(
                        widget.arrCar.arrImgUrl![index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder_image.webp',
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.arrCar.arrImgUrl!.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.jumpToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key
                                ? AppColors.primary
                                : Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              )
            else
              Image.asset(
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
            widget.arrCar.strCarCategory?.name ?? 'N/A',
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
        Expanded(
          child: Text(
            '${widget.arrCar.strBrand} ${widget.arrCar.strModel}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
                ' ${widget.arrCar.intRating?.toStringAsFixed(1) ?? 'N/A'}',
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
      widget.arrCar.strDescription ?? 'No description available',
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
