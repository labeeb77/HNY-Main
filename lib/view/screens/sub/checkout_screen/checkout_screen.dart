import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/data/providers/mycart_provider.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/checkout_payment_screen.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/price_calculation.dart';
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
 late String? arrCarId ;
 @override
  void initState() {
    arrCarId = widget.arrCar.id!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        // Get only gadgets with quantity > 0
        final selectedGadgets = bookingProvider.gadgets
            .where((gadget) => gadget.quantity > 0)
            .toList();

        return WillPopScope(
          onWillPop: () async {
            if (arrCarId != null) {
              Navigator.pop(context);
              return true;
            } else {
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              return true;
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: const CommonAppBar(
              showLeading: true,
              goToHome: true,
              title: 'My Cart',
            ),
            body: SafeArea(
                child: arrCarId != null
                    ? Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildVehicleCard(
                                      widget.arrCar.strModel ?? 'Unknown',
                                      widget.arrCar.strBrand ?? 'Unknown',
                                      bookingProvider.calculateTotalAmount(
                                          widget.arrCar.intPricePerDay
                                                  ?.toInt() ??
                                              0,
                                          widget.arrCar.intPricePerWeek
                                                  ?.toInt() ??
                                              0,
                                          widget.arrCar.intPricePerMonth
                                                  ?.toInt() ??
                                              0),
                                      widget.arrCar.strImgUrl ??
                                          'assets/images/placeholder_image.webp',
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
                                            bookingProvider,
                                            gadget.name,
                                            findSingleGadgetAmount(bookingProvider.totalDays,gadget.monthlyPrice,gadget.weeklyPrice,gadget.pricePerDay??0,gadget.quantity),
                                            gadget.image,
                                            quantity: gadget.quantity,
                                            onQuantityChanged: (newQuantity) {
                                              bookingProvider
                                                  .updateGadgetQuantity(
                                                      gadget.id, newQuantity);
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      );
                                    }).toList(),

                                    // buildPromoCodeSection(),
                                    // const SizedBox(height: 24),
                                    buildSuperCoinsSection(context),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Bottom section
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              border: Border(
                                top: BorderSide(
                                    color: AppColors.containerBorderColor),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildOrderSummary(
                                  arrCar: widget.arrCar,
                                  provider: bookingProvider,
                                  vehiclePrice:
                                      bookingProvider.calculateTotalAmount(
                                          widget.arrCar.intPricePerDay
                                                  ?.toInt() ??
                                              0,
                                          widget.arrCar.intPricePerWeek
                                                  ?.toInt() ??
                                              0,
                                          widget.arrCar.intPricePerMonth
                                                  ?.toInt() ??
                                              0),
                                  gadgetPrice:
                                      bookingProvider.totalGadgetPrice.toInt(),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: PrimaryElevateButton(
                                    ontap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckoutPaymentScreen(
                                            totalAmount: bookingProvider
                                                .calculateFinalTotalAmount(
                                                  vehicleDailyRate: widget
                                                          .arrCar.intPricePerDay
                                                          ?.toInt() ??
                                                      0,
                                                  vehicleWeeklyRate: widget
                                                          .arrCar
                                                          .intPricePerWeek
                                                          ?.toInt() ??
                                                      0,
                                                  vehicleMonthlyRate: widget
                                                          .arrCar
                                                          .intPricePerMonth
                                                          ?.toInt() ??
                                                      0,
                                                )
                                                .toInt(),
                                            carDetails: widget.arrCar,
                                          ),
                                        ),
                                      );
                                    },
                                    buttonName: "Proceed to checkout",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.remove_shopping_cart,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Text(
                                'Your cart is empty',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                child: Text(
                                  'Add some items to your cart to proceed with checkout',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 36),
                              Container(
                                  width: 220,
                                  height: 50,
                                  child: AppButton(
                                      child: Text(
                                        "Continue Booking",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () {
                                        while (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                      })),
                            ],
                          ),
                        ),
                      )),
          ),
        );
      },
    );
  }

  Widget _buildVehicleCard(
    String model,
    String brand,
    int price,
    String imagePath,
    String startDate,
    String endDate,
    String pickup,
    String dropoff,
  ) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    log('chop car :$imagePath');
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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 100,
                  child: imagePath != null && imagePath.isNotEmpty
                      ? Image.network(
                          imagePath,
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/placeholder_image.webp',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/images/placeholder_image.webp',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$brand $model",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.red,
                            child: IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 18, color: AppColors.white),
                              onPressed: () {
                                _showDeleteConfirmation(
                                    context,
                                    widget.arrCar,
                                    Provider.of<MyCartProvider>(context,
                                        listen: false));
                              },
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Text(
                        "${price.toStringAsFixed(1)} AED",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 12, color: Colors.grey),
                                    const SizedBox(width: 2),
                                    Text(
                                      'Start: $startDate ${bookingProvider.formattedStartTime}',
                                      style: const TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 12, color: Colors.grey),
                                    const SizedBox(width: 2),
                                    Text(
                                      'End: $endDate ${bookingProvider.formattedEndTime}',
                                      style: const TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(2),
                      buildLocationRow(pickup, dropoff),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, ArrCar item, MyCartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text(
            'Are you sure you want to remove this item from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              cartProvider.deleteCartItem(await findCartItem(item.id!));
              arrCarId = null;
              setState(() {});
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Updated addon card to include quantity and callback
  Widget buildAddonCard(
      BookingProvider bookingProvider, String name,  price, String imagePath,
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
        padding: const EdgeInsets.all(10),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$price AED",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _getGadgetCalculationText(bookingProvider.totalDays, price, quantity),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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

  PriceCalculation _calculateGadgetPricing() {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final totalDays = bookingProvider.totalDays;

    double totalGadgetPrice = 0;
    String? priceType;

    for (var gadget in bookingProvider.gadgets) {
      if (gadget.quantity > 0) {
        if (totalDays >= 30) {
          // Monthly pricing for gadgets
          final monthlyPrice =
              (gadget.price * 30 / 30) * totalDays * gadget.quantity;
          totalGadgetPrice += monthlyPrice;
          priceType = 'Monthly Rate';
        } else if (totalDays >= 8) {
          // Weekly pricing for gadgets
          final weeklyPrice =
              (gadget.price * 7 / 7) * totalDays * gadget.quantity;
          totalGadgetPrice += weeklyPrice;
          priceType = 'Weekly Rate';
        } else {
          // Daily pricing for gadgets
          final dailyPrice = gadget.price * totalDays * gadget.quantity;
          totalGadgetPrice += dailyPrice;
          priceType = 'Daily Rate';
        }
      }
    }

    return PriceCalculation(
      totalPrice: totalGadgetPrice,
      priceType: priceType,
    );
  }

  // Updated order summary to include gadget price
  Widget buildOrderSummary({
    required ArrCar arrCar,
    required BookingProvider provider,
    required int vehiclePrice,
    required int gadgetPrice,
  }) {
    // Calculate final total amount
    final finalAmount = provider.calculateFinalTotalAmount(
      vehicleDailyRate: arrCar.intPricePerDay?.toInt() ?? 0,
      vehicleWeeklyRate: arrCar.intPricePerWeek?.toInt() ?? 0,
      vehicleMonthlyRate: arrCar.intPricePerMonth?.toInt() ?? 0,
    );

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
        buildSummaryRow(
          'Vehicle Rental',
          '${vehiclePrice.toStringAsFixed(1)} AED',
        ),
        if (provider.totalGadgetPrice > 0.0)
          buildSummaryRow(
            'Add-ons',
            '${provider.totalGadgetPrice.toStringAsFixed(1)} AED',
          ),
        const Divider(height: 24),
        buildSummaryRow(
          'Total',
          '${finalAmount.toStringAsFixed(1)} AED',
          isTotal: true,
        ),
      ],
    );
  }

  Widget buildSummaryRow(
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
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
        ],
      ),
    );
  }

  String _getGadgetCalculationText(int days,  price, int quantity) {
    final dailyPrice = price / days;
    return '($quantity × ${dailyPrice.toStringAsFixed(1)} AED/day × $days days)';
  }

  String _getTotalGadgetCalculationText(BookingProvider provider) {
    final gadgets = provider.gadgets.where((g) => g.quantity > 0);
    if (gadgets.isEmpty) return '';
    
    final List<String> calculations = [];
    for (var gadget in gadgets) {
      final dailyPrice = findSingleGadgetAmount(
        provider.totalDays,
        gadget.monthlyPrice ?? 0,
        gadget.weeklyPrice ?? 0,
        gadget.pricePerDay ?? 0,
        1
      ) / provider.totalDays;
      calculations.add('${gadget.quantity} × ${dailyPrice.toStringAsFixed(1)} AED/day');
    }
    return '(${calculations.join(' + ')}) × ${provider.totalDays} days';
  }

  // Placeholder methods for the other widgets
  Widget buildDateRow(String startDate, String endDate) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 14),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                startDate,
                style: const TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                endDate,
                style: const TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
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
      child: const Row(
        children: [
          Icon(Icons.discount, color: AppColors.orange),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Apply Promo Code',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
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

  findCartItem(String carId) async {
    await Provider.of<MyCartProvider>(context, listen: false).fetchCartItems();
    for (var element
        in Provider.of<MyCartProvider>(context, listen: false).cartItems) {
      if (element.itemDetails?.id == carId) {
        return element.id!;
      }
    }
  }

   findSingleGadgetAmount(
      days, monthlyAmount, weeklyAmount, dailyAmount, qty) {
    if (qty > 0) {
      if (days >= 30) {
        // Monthly pricing
        final monthlyPrice = (monthlyAmount / 30) * days * qty;
        return monthlyPrice;
      } else if (days >= 8) {
        // Weekly pricing
        final weeklyPrice = (weeklyAmount / 7) * days * qty;
        return weeklyPrice;
      } else {
        // Daily pricing
        final dailyPrice = dailyAmount * days * qty;
        return dailyPrice;
      }
    }
    return 0;
  }
}
