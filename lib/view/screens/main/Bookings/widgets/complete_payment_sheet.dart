import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/payment_options_widget.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final TextEditingController _altMobileController = TextEditingController();
  String? errorMessage;
  String _altCountryCode = '971';

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.balanceAmount.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _altMobileController.dispose();
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
      final bookingProvider =
          Provider.of<BookingProvider>(context, listen: false);
      final amount = isFullPayment
          ? widget.balanceAmount
          : double.parse(_amountController.text);
      final altMobile = _altMobileController.text.trim().isNotEmpty
          ? '$_altCountryCode${_altMobileController.text.trim()}'
          : null;

        await bookingProvider.createPayment(
        context,
        bookingId: widget.bookingId,
        amount: amount,
        strBookingId: widget.strBookingId,
        strAltMobileNo: altMobile,
      );

   
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
          builder: (context, value, child) => IntrinsicHeight(
            child: Column(
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
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Full Amount',
                          style: TextStyle(fontSize: 13),
                        ),
                        value: true,
                        groupValue: isFullPayment,
                        onChanged: (value) {
                          setState(() {
                            isFullPayment = value!;
                            if (isFullPayment) {
                              _amountController.text =
                                  widget.balanceAmount.toStringAsFixed(2);
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Custom Amount',
                          style: TextStyle(fontSize: 13),
                        ),
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
                // Alternative Mobile Number Input
                const Text(
                  'Alternative Mobile Number',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          setState(() {
                            _altCountryCode = countryCode.dialCode?.replaceAll('+', '') ?? '971';
                          });
                        },
                        initialSelection: 'AE',
                        favorite: const ['AE'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        padding: EdgeInsets.zero,
                        dialogSize: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _altMobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter alternative mobile number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty && value.length < 9) {
                            return 'Phone number must be at least 9 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
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
                      buttonName:
                          isLoading ? "Processing..." : "Proceed to payment",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
