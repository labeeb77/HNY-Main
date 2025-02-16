import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/checkout_payment_screen.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/widgets/random_widget.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final ArrCar arrCar;

  const CartScreen({super.key, required this.arrCar});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        // Get only gadgets with quantity > 0
        final selectedGadgets = bookingProvider.gadgets
            .where((gadget) => gadget.quantity > 0)
            .toList();

             final vehiclePrice = bookingProvider.calculateTotalAmount(
            widget.arrCar.intPricePerDay ?? 0);
        final gadgetPrice = bookingProvider.totalGadgetPrice.toInt();
        final totalAmount = vehiclePrice + gadgetPrice;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CommonAppBar(
            title: 'My Cart',
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
                        widget.arrCar.strModel ?? 'Ford Escape',
                        bookingProvider.calculateTotalAmount(
                            widget.arrCar.intPricePerDay ?? 00),
                        widget.arrCar.strImgUrl ??
                            'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_640.jpg',
                        bookingProvider.formattedStartDate,
                        bookingProvider.formattedEndDate,
                        bookingProvider.pickupAddress,
                        bookingProvider.dropoffAddress,
                      ),
                      const SizedBox(height: 16),

                      // Display selected gadgets
                      ...selectedGadgets.map((gadget) {
                        return Column(
                          children: [
                            buildAddonCard(
                              gadget.name,
                              gadget.price.toInt(),
                              gadget.image,
                              quantity: gadget.quantity,
                              onQuantityChanged: (newQuantity) {
                                bookingProvider.updateGadgetQuantity(
                                    gadget.id, newQuantity);
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),

                      buildPromoCodeSection(),
                      const SizedBox(height: 24),
                      buildSuperCoinsSection(context),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      border: Border(
                          top: BorderSide(
                              color: AppColors.containerBorderColor))),
                  child: Column(
                    children: [
                      buildOrderSummary(
                        vehiclePrice:  bookingProvider.calculateTotalAmount(
                            widget.arrCar.intPricePerDay ?? 00), // Replace with actual vehicle price
                        gadgetPrice: bookingProvider.totalGadgetPrice.toInt(),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: PrimaryElevateButton(
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CheckoutPaymentScreen(totalAmount: totalAmount,carDetails: widget.arrCar,),
                                  ));
                            },
                            buttonName: "Proceed to checkout",
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVehicleCard(
    String name,
    int price,
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
              child: SizedBox(
                width: 100,
                height: 134,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
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
                      "AED $price",
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    buildDateRow(startDate, endDate),
                    buildLocationRow(pickup, dropoff),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  // Updated addon card to include quantity and callback
  Widget buildAddonCard(String name, int price, String imagePath,
      {int quantity = 1, Function(int)? onQuantityChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            spreadRadius: 4,
            color: Color.fromARGB(255, 231, 231, 231),
            blurRadius: 6,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'AED $price',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onQuantityChanged != null)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: quantity > 0
                        ? () => onQuantityChanged(quantity - 1)
                        : null,
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => onQuantityChanged(quantity + 1),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Updated order summary to include gadget price
  Widget buildOrderSummary({
    required int vehiclePrice,
    required int gadgetPrice,
  }) {
    final totalPrice = vehiclePrice + gadgetPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        buildSummaryRow('Vehicle Rental', 'AED $vehiclePrice'),
        if (gadgetPrice > 0) buildSummaryRow('Add-ons', 'AED $gadgetPrice'),
        const Divider(height: 24),
        buildSummaryRow(
          'Total',
          'AED $totalPrice',
          isTotal: true,
        ),
      ],
    );
  }

  Widget buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? AppColors.orange : null,
            ),
          ),
        ],
      ),
    );
  }

  // Placeholder methods for the other widgets
  Widget buildDateRow(String startDate, String endDate) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 14),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            '$startDate - $endDate',
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget buildLocationRow(String pickup, String dropoff) {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 14),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            '$pickup - $dropoff',
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget buildPromoCodeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.discount, color: AppColors.orange),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Apply Promo Code',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  Widget buildSuperCoinsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.monetization_on, color: Colors.blue),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use SuperCoins',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'You have 100 coins',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: false,
            onChanged: (value) {},
            activeColor: AppColors.orange,
          ),
        ],
      ),
    );
  }
}
