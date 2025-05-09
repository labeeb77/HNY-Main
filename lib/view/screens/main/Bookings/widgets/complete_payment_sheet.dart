import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/payment_options_widget.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:provider/provider.dart';

class CompletePaymentSheet extends StatefulWidget {
  final String bookingId;
  final String strBookingId;
  final double balanceAmount;

  const CompletePaymentSheet({
    super.key,
    required this.bookingId,
    required this.strBookingId,
    required this.balanceAmount,
  });

  @override
  State<CompletePaymentSheet> createState() => _CompletePaymentSheetState();
}

class _CompletePaymentSheetState extends State<CompletePaymentSheet> {
  bool isFullPayment = true;
  bool isLoading = false;
  final TextEditingController _amountController = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.balanceAmount.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handlePayment() async {
    if (!isFullPayment && (double.tryParse(_amountController.text) ?? 0) <= 0) {
      setState(() {
        errorMessage = 'Please enter a valid amount';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
      final amount = isFullPayment 
          ? widget.balanceAmount 
          : double.parse(_amountController.text);

      final success = await bookingProvider.createPayment(
        context,
        bookingId: widget.bookingId,
        amount: amount,
        strBookingId: widget.strBookingId,
      );

      if (success && mounted) {
        Navigator.pop(context, true); // Return true to indicate successful payment
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Payment failed. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Consumer<HomeController>(
          builder: (context, value, child) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Complete Payment',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              // Payment Type Selection
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('Pay Full Amount'),
                      value: true,
                      groupValue: isFullPayment,
                      onChanged: (value) {
                        setState(() {
                          isFullPayment = value!;
                          if (isFullPayment) {
                            _amountController.text = widget.balanceAmount.toStringAsFixed(2);
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('Pay Custom Amount'),
                      value: false,
                      groupValue: isFullPayment,
                      onChanged: (value) {
                        setState(() {
                          isFullPayment = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Amount Input
              if (!isFullPayment) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    prefixText: 'AED ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: errorMessage,
                  ),
                ),
              ],

              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                      child: Text(
                        "${isFullPayment ? widget.balanceAmount.toStringAsFixed(2) : double.parse(_amountController.text).toStringAsFixed(2)} AED",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryElevateButton(
                    buttonName: "Cancel",
                    isGrey: false,
                    ontap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  PrimaryElevateButton(
                    ontap: isLoading ? null : _handlePayment,
                    buttonName: isLoading ? "Processing..." : "Proceed to payment",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
