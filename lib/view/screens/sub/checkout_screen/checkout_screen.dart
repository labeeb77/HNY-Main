import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController promoController = TextEditingController();
  bool superCoinEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
                backgroundColor: AppColors.white,
                child: Icon(Icons.arrow_back, color: Colors.black)),
          ),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        scrolledUnderElevation: 0.0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVehicleCard(
                    'Ford Escape',
                    'AED 5,000',
                    'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
                    'October 1, 2024',
                    'October 4, 2024',
                    'Nagavara, Bengaluru',
                    'Mentric Technology Park',
                  ),
                  const SizedBox(height: 16),
                  _buildVehicleCard(
                    'Hyundai Creta',
                    'AED 7,000',
                    'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
                    'October 5, 2024',
                    'October 10, 2024',
                    'Nagavara, Bengaluru',
                    'Mentric Technology Park',
                  ),
                  const SizedBox(height: 16),
                  _buildAddonCard(
                    'Child Seat',
                    10,
                    'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
                  ),
                  const SizedBox(height: 16),
                  _buildAddonCard(
                    'iPhone Charger',
                    10,
                    'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
                  ),
                  const SizedBox(height: 32),
                  _buildPromoCodeSection(),
                  const SizedBox(height: 24),
                  _buildSuperCoinsSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                      top: BorderSide(color: AppColors.containerBorderColor))),
              child: Column(
                children: [
                  _buildOrderSummary(),
                  const SizedBox(height: 24),
                  SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: PrimaryElevateButton(
                        buttonName: "Proceed to checkout",
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(
    String name,
    String price,
    String imagePath,
    String startDate,
    String endDate,
    String pickup,
    String dropoff,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 4,
                color: Color.fromARGB(255, 231, 231, 231),
                blurRadius: 6)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imagePath,
                width: 100,
                height: 132,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.orange,
                        child: IconButton(
                          icon: const Icon(Icons.edit,
                              size: 18, color: AppColors.white),
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _buildDateRow(startDate, endDate),
                  _buildLocationRow(pickup, dropoff),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(String startDate, String endDate) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(67, 96, 177, 204),
          borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        children: [
          Text(
            startDate,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward, size: 16, color: Colors.black54),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              endDate,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildLocationRow(String pickup, String dropoff) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(67, 139, 166, 109),
          borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        children: [
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '$pickup → $dropoff',
              style: const TextStyle(fontSize: 12, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.location_on, size: 16, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildAddonCard(String name, double price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 4,
                color: Color.fromARGB(255, 231, 231, 231),
                blurRadius: 6)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imagePath,
                height: 149,
                width: 144,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(16),
                Row(
                  children: [
                    const Text(
                      'Qty : ',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                        height: 29,
                        width: 29,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: Icon(
                            Icons.remove,
                          ),
                        )),
                    const SizedBox(width: 14),
                    const Text(
                      '1',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 14),
                    SizedBox(
                        height: 29,
                        width: 29,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                        )),
                  ],
                ),
                Gap(16),
                Row(
                  children: [
                    Text(
                      'Price Per set :',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    Gap(8),
                    Text(
                      '${price.toStringAsFixed(0)} AED',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 4,
                color: Color.fromARGB(255, 231, 231, 231),
                blurRadius: 6)
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: promoController,
              decoration: const InputDecoration(
                hintText: 'Promo code',
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Apply now',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuperCoinsSection() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 6),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 4,
                color: Color.fromARGB(255, 231, 231, 231),
                blurRadius: 6)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const Text(
                      'You will earn up to 100 Super coins on this bookings')),
              const Spacer(),
              Image.network(
                  'https://s3-alpha-sig.figma.com/img/44b6/5a8d/b0f8c5896b77ac586570e13868d8d99f?Expires=1737331200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CA3nh3H4jK1DcAuX4UdK9wB6ZF7F1VuekEf35VYjfzwGIY7H9jwLpqTqZfbv6X6Lih7SybrB5v7-Onxs8RNkeGs-FuD8CPGfRqosvNbVxGbhX4lpCauaiTGXPbcQ02KRfJMXEPUDbebUHbqtobO~L2oYBO20~2Zs8pjOYGJ5AJ9OXXstD4~hS-rhdJkQV0mvYbFEku2NJ2xPulf2iqNIYstn2RVK9sFhI1h3fgoMa8lPtXxFGVe6T0xI0UHesUu3H~MEzJexF9zJVmtH4~7Iom6HgwS3KGZPKLaTrSAJfOPj0ns8hz0ZHewn4wn8U9UVH7ICiA1Gl3X~jv1atYOtcw__',
                  height: 50),
            ],
          ),
          Row(
            children: [
              const Text(
                'Available balance : ',
                style: TextStyle(color: Colors.black),
              ),
              const Icon(Icons.currency_bitcoin, size: 16, color: Colors.amber),
              const Text(' 250'),
              const Spacer(),
              Switch(
                value: superCoinEnabled,
                onChanged: (value) {
                  setState(() {
                    superCoinEnabled = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _buildSummaryRow('Altis', '25 AED'),
        _buildSummaryRow('Dropping cost', '5 AED'),
        _buildSummaryRow('Taxes ( 10% )', '2.5 AED'),
        _buildSummaryRow(
          'Total Price',
          '12,510 AED',
          isBold: true,
          textColor: Color(0xFF82868B),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color textColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Color(0xFF82868B),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 24 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? AppColors.primary : textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Proceed to checkout',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
