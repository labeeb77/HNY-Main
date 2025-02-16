import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalRideOptionsLoader extends StatelessWidget {
  final int itemCount;
  
  const HorizontalRideOptionsLoader({
    super.key, 
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 500 + (index * 50)),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset((1 - value) * 20, 0),
                      child: buildLoadingRideOption(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget buildLoadingRideOption() {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey[200],
          ),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
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
          ),
        ),
      ],
    );
  }
}