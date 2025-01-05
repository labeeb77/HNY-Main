import 'package:flutter/material.dart';

class CarHeader extends StatelessWidget {
  const CarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
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
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {},
                ),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Electric',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const Spacer(),
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const Text(' 4.8'),
      ],
    );
  }

  Widget _buildCarTitle() {
    return const Text(
      'Ford Escape',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCarDescription() {
    return const Text(
      'Experience the comfort and versatility of the Ford Escape – a compact SUV with advanced safety, spacious interiors, and smart tech for every journey.',
      style: TextStyle(color: Colors.grey),
    );
  }
}
