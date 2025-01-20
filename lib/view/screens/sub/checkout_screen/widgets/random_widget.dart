import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';

Widget buildSummaryRow(
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
          style: const TextStyle(
            // fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Color(0xFF82868B),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 24 : 16,
            fontWeight: FontWeight.w600,
            color: isBold ? AppColors.primary : textColor,
          ),
        ),
      ],
    ),
  );
}

Widget buildSuperCoinsSection(context) {
  bool superCoinEnabled = false;
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
              onChanged: (value) {},
              activeColor: Colors.green,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildOrderSummary() {
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
      buildSummaryRow('Altis', '25 AED'),
      buildSummaryRow('Dropping cost', '5 AED'),
      buildSummaryRow('Taxes ( 10% )', '2.5 AED'),
      buildSummaryRow(
        'Total Price',
        '12,510 AED',
        isBold: true,
        textColor: const Color(0xFF82868B),
      ),
    ],
  );
}

Widget buildBookingSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Booking Summary',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
              child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text("Download Invoice"),
            icon: const Icon(Icons.file_download),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                elevation: 0.0,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(14))),
          )),
        ],
      ),
      const SizedBox(height: 16),
      buildSummaryRow('Booking id ', 'BK30001'),
      buildSummaryRow('Start date', 'October 1, 2024'),
      buildSummaryRow('End date', 'October 5, 2024'),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Balance amount',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color(0xFF82868B),
              ),
            ),
            Text(
              '1,000 AED',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
      ),
      buildSummaryRow(
        'Total amount',
        '12,510 AED',
        isBold: true,
        textColor: const Color(0xFF82868B),
      ),
    ],
  );
}

Widget buildDateRow(String startDate, String endDate) {
  return Container(
    decoration: BoxDecoration(
        color: const Color.fromARGB(67, 96, 177, 204),
        borderRadius: BorderRadius.circular(6)),
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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

Widget buildLocationRow(String pickup, String dropoff) {
  return Container(
    decoration: BoxDecoration(
        color: const Color.fromARGB(67, 139, 166, 109),
        borderRadius: BorderRadius.circular(6)),
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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

Widget buildAddonCard(String name, double price, String imagePath,
    [bool isFromBooking = false]) {
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
            child: SizedBox(
              height: 149,
              width: 144,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 28),
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
              const Gap(16),
              isFromBooking
                  ? const Text(
                      'AED 5,000',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Row(
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
                              child: const Icon(
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
                        const SizedBox(
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
              const Gap(16),
              isFromBooking
                  ? const Row(
                      children: [
                        Text(
                          "Qty : ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        Text(
                          "2",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        const Text(
                          'Price Per set :',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const Gap(8),
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

Widget buildPromoCodeSection() {
  final TextEditingController promoController = TextEditingController();

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
