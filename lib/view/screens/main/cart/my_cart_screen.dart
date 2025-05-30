import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/cart/cartlist_model.dart';
import 'package:hny_main/data/providers/mycart_provider.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/checkout_payment_screen.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hny_main/view/screens/sub/location_picker_screen.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyCartProvider>().fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Cart',
      ),
      body: Consumer<MyCartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.error != null) {
            return Center(child: Text(cartProvider.error!));
          }

          if (cartProvider.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          // Get the first item only
          final item = cartProvider.cartItems[0];
          final int totalDays =
              _calculateTotalDays(item.strStartDate, item.strEndDate);
          final int totalAmount = _calculateTotalAmount(
              item.itemDetails?.intPricePerDay?.toInt() ?? 0,
              item.itemDetails?.intPricePerWeek?.toInt() ?? 0,
              item.itemDetails?.intPricePerMonth?.toInt() ?? 0,
              totalDays);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                                      child: Image.network(
                                        item.itemDetails?.strImgUrl ?? '',
                                        fit: BoxFit.fitHeight,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/images/placeholder_image.webp',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.itemDetails?.strType == 'CAR'
                                                  ? "${item.itemDetails?.strBrand ?? ''} ${item.itemDetails?.strModel ?? ''}"
                                                  : item.itemDetails?.strName ??
                                                      "Unknown",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      AppColors.red,
                                                  child: IconButton(
                                                    icon: const Icon(Icons.edit,
                                                        size: 18,
                                                        color: AppColors.white),
                                                    onPressed: () =>
                                                        _showEditDialog(context,
                                                            item, cartProvider,),
                                                            
                                                    constraints:
                                                        const BoxConstraints(),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      AppColors.red,
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        size: 18,
                                                        color: AppColors.white),
                                                    onPressed: () =>
                                                        _showDeleteConfirmation(
                                                            context,
                                                            item,
                                                            cartProvider),
                                                    constraints:
                                                        const BoxConstraints(),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${totalAmount.toStringAsFixed(1)} AED",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.orange,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.calendar_month,
                                                          size: 12,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 2),
                                                      Text(
                                                        'Start: ${_formatDateTime(item.strStartDate)}',
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.calendar_month,
                                                          size: 12,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 2),
                                                      Text(
                                                        'End: ${_formatDateTime(item.strEndDate)}',
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on,
                                                size: 14),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                '${item.strPickupLocationAddress ?? 'Select Location'} - ${item.strDeliveryLocationAddress ?? 'Select Location'}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildSuperCoinsSection(context),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(color: AppColors.containerBorderColor),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Vehicle Rental',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${totalAmount.toStringAsFixed(1)} AED',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${totalAmount.toStringAsFixed(1)} AED',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: PrimaryElevateButton(
                        ontap: () {
                          if (item.isAvailable ?? false) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPaymentScreen(
                                  totalAmount: totalAmount,
                                  cartdata: item,
                                  isCartPage: true,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'This item is not available at this date range'),
                                backgroundColor: Colors.black,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        buttonName: "Proceed to checkout",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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

  String _formatDateTime(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM d, yyyy hh:mm a').format(date);
  }

  void _showDeleteConfirmation(
      BuildContext context, ArrList item, MyCartProvider cartProvider) {
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
            onPressed: () {
              Navigator.pop(context);
              if (item.id != null) {
                cartProvider.deleteCartItem(item.id!);
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, ArrList item, MyCartProvider cartProvider) {
    String? updatedPickupAddress;
    String? updatedDropoffAddress;
    List<double>? updatedPickupCoords;
    List<double>? updatedDropoffCoords;
    DateTime? updatedStartDate;
    DateTime? updatedEndDate;

    // Initialize dates with proper validation
    final now = DateTime.now();
    final initialStartDate = item.strStartDate ?? now;
    final initialEndDate = item.strEndDate ?? now;

    // Ensure dates are not in the past
    final startDate = initialStartDate.isBefore(now) ? now : initialStartDate;
    final endDate = initialEndDate.isBefore(now) ? now : initialEndDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Edit Cart Item',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Quantity Input
                  
                  // Date Range Picker
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: updatedStartDate ?? startDate,
                              firstDate: now,
                              lastDate: now.add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() {
                                updatedStartDate = date;
                                // If end date is before start date, update it too
                                if (updatedEndDate != null &&
                                    updatedEndDate!.isBefore(date)) {
                                  updatedEndDate = date;
                                }
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Start',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  updatedStartDate != null
                                      ? DateFormat('MMM dd, yyyy')
                                          .format(updatedStartDate!)
                                      : DateFormat('MMM dd, yyyy')
                                          .format(startDate),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: updatedEndDate ?? endDate,
                              firstDate: updatedStartDate ?? startDate,
                              lastDate: now.add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() {
                                updatedEndDate = date;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'End',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  updatedEndDate != null
                                      ? DateFormat('MMM dd, yyyy')
                                          .format(updatedEndDate!)
                                      : DateFormat('MMM dd, yyyy')
                                          .format(endDate),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Location Buttons
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Locations',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Pickup Location
                          InkWell(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationPickerScreen(
                                    from: "Pick-Up",
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  updatedPickupAddress = result['address'];
                                  updatedPickupCoords = [
                                    result['lat'],
                                    result['long']
                                  ];
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.orange),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Pickup Location',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          updatedPickupAddress ??
                                              item.strPickupLocationAddress ??
                                              'Select Location',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: updatedPickupAddress != null
                                                ? Colors.green
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Delivery Location
                          InkWell(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationPickerScreen(
                                    from: "Drop Off",
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  updatedDropoffAddress = result['address'];
                                  updatedDropoffCoords = [
                                    result['lat'],
                                    result['long']
                                  ];
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.orange),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Delivery Location',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          updatedDropoffAddress ??
                                              item.strDeliveryLocationAddress ??
                                              'Select Location',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: updatedDropoffAddress != null
                                                ? Colors.green
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Save Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await cartProvider.updateCartItem(
                            id: item.id!,
                            intCount:item.intCount ?? 1,
                            strStartDate: updatedStartDate ??
                                item.strStartDate ??
                                DateTime.now(),
                            strEndDate: updatedEndDate ??
                                item.strEndDate ??
                                DateTime.now(),
                            strPickupLocation: updatedPickupCoords ??
                                [
                                  item.strPickupLocation?.coordinates?[0] ?? 0.0,
                                  item.strPickupLocation?.coordinates?[1] ?? 0.0,
                                ],
                            strDeliveryLocation: updatedDropoffCoords ??
                                [
                                  item.strDeliveryLocation?.coordinates?[0] ??
                                      0.0,
                                  item.strDeliveryLocation?.coordinates?[1] ??
                                      0.0,
                                ],
                            strPickupLocationAddress: updatedPickupAddress ??
                                item.strPickupLocationAddress ??
                                '',
                            strDeliveryLocationAddress: updatedDropoffAddress ??
                                item.strDeliveryLocationAddress ??
                                '',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _calculateTotalDays(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return 1; // Default to 1 day if dates not selected
    }

    // Create DateTime objects with times set to 0 since we only have dates
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);

    // Calculate difference in days (add 1 to include both start and end date)
    final difference = end.difference(start);
    int days = difference.inDays + 1;

    // Ensure minimum of 1 day
    return days > 0 ? days : 1;
  }

  int _calculateTotalAmount(
      int pricePerDay, int pricePerWeek, int pricePerMonth, int totalDays) {
    if (totalDays >= 30) {
      // Monthly pricing
      final monthlyPrice = (pricePerMonth / 30) * totalDays;
      return monthlyPrice.toInt();
    } else if (totalDays >= 8) {
      // Weekly pricing
      final weeklyPrice = (pricePerWeek / 7) * totalDays;
      return weeklyPrice.toInt();
    } else {
      // Daily pricing
      final dailyPrice = pricePerDay * totalDays;
      return dailyPrice.toInt();
    }
  }
}
