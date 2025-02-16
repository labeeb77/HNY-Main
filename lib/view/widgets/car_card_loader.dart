import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarCardSkeletonLoader extends StatelessWidget {
  final Orientation orientation;
  final MediaQueryData mediaQuery;
  final int itemCount;

  const CarCardSkeletonLoader({
    super.key,
    required this.orientation,
    required this.mediaQuery,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 500 + (index * 100)),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 20),
                  child: _buildSkeletonCard(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(1, 1),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container skeleton
          Container(
            height: orientation == Orientation.portrait
                ? mediaQuery.size.height / 4.5
                : mediaQuery.size.width / 4.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: Stack(
              children: [
                // Shimmer effect for image
                _buildShimmerContainer(
                  height: orientation == Orientation.portrait
                      ? mediaQuery.size.height / 4.5
                      : mediaQuery.size.width / 4.5,
                  width: double.infinity,
                  borderRadius: 12,
                ),
                
                // Top row with rating, category and favorite button
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Rating container
                          _buildShimmerContainer(
                            height: 22,
                            width: 60,
                            borderRadius: 10,
                          ),
                          const SizedBox(width: 12),
                          // Category container
                          _buildShimmerContainer(
                            height: 22,
                            width: 80,
                            borderRadius: 20,
                          ),
                        ],
                      ),
                      // Favorite button
                      _buildShimmerContainer(
                        height: 32,
                        width: 32,
                        borderRadius: 16,
                        isCircular: true,
                      ),
                    ],
                  ),
                ),
                
                // Bottom row with features
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildShimmerContainer(height: 22, width: 80, borderRadius: 5),
                      _buildShimmerContainer(height: 22, width: 80, borderRadius: 5),
                      _buildShimmerContainer(height: 22, width: 80, borderRadius: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Bottom section with name, price and button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car name
                    _buildShimmerContainer(
                      height: 16,
                      width: 120,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 8),
                    // Price
                    _buildShimmerContainer(
                      height: 16,
                      width: 100,
                      borderRadius: 4,
                    ),
                  ],
                ),
                // Button
                _buildShimmerContainer(
                  height: 36,
                  width: 100,
                  borderRadius: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer({
    required double height,
    required double width,
    required double borderRadius,
    bool isCircular = false,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, child) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: isCircular
                ? null
                : BorderRadius.circular(borderRadius),
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment(-1.0 + (value * 2), 0),
              end: Alignment(-1.0 + (value * 2) + 1, 0),
              colors: [
                Colors.grey[200]!,
                Colors.grey[300]!,
                Colors.grey[200]!,
              ],
            ),
          ),
        );
      },
    );
  }
}