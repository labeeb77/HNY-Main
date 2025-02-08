import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/auth_provider.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class OtpVerifyScreen extends StatefulWidget {
  final otpToken;
  const OtpVerifyScreen({super.key, required this.otpToken});

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final focus0 = FocusNode();
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus2Listner = FocusNode();
  final focus1Listner = FocusNode();
  final focusListner = FocusNode();

  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // @override
  // void dispose() {
  //   _otpFieldOne.dispose();
  //   _otpFieldTwo.dispose();
  //   _otpFieldThree.dispose();
  //   _otpFieldFour.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: InkWell(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    height: 86,
                    child: Image.asset(
                      "assets/logo/auth_screen_logo.png",
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 86),
                    ),
                  ),
                  Gap(screenHeight * 0.05),
                  _buildWelcomeText(),
                  const SizedBox(height: 50),
                  Form(key: _formKey, child: otp()),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48 - 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Didn't receive the otp?",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          "Resend OTP",
                          style: TextStyle(color: AppColors.blue, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: PrimaryElevateButton(
                      buttonName: "Next",
                      ontap: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          verifyOtp(context, AuthProvider(context), widget.otpToken);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64.0),
                    child: AppText(
                        color: AppColors.primary,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                        "by clicking next, you agree to our  Privacy and Policy"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verify Account!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Enter 4-digit code we’ve sent to at your mobile number',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget otp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48 - 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // OTP Input 1
          SizedBox(
            height: 60,
            width: 60,
            child: TextField(
              focusNode: focus0,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              cursorHeight: 30,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black, fontSize: 28),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              controller: otp1Controller,
              onChanged: (v) {
                if (v != '') {
                  setState(() {
                    otp1Controller.text = v;
                  });
                  FocusScope.of(context).requestFocus(focus);
                }
              },
            ),
          ),
          const SizedBox(width: 14),

          // OTP Input 2
          SizedBox(
            height: 60,
            width: 60,
            child: RawKeyboardListener(
              focusNode: focusListner,
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.backspace &&
                    otp2Controller.text == '') {
                  FocusScope.of(context).requestFocus(focus0);
                }
              },
              child: TextField(
                cursorHeight: 30,
                focusNode: focus,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                style: const TextStyle(color: Colors.black, fontSize: 28),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                controller: otp2Controller,
                onChanged: (v) {
                  if (v != '') {
                    setState(() {
                      otp2Controller.text = v;
                    });
                    FocusScope.of(context).requestFocus(focus1);
                  } else {
                    setState(() {
                      otp2Controller.text = '';
                    });
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 14),

          // OTP Input 3
          SizedBox(
            height: 60,
            width: 60,
            child: RawKeyboardListener(
              focusNode: focus1Listner,
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.backspace &&
                    otp3Controller.text == '') {
                  FocusScope.of(context).requestFocus(focus);
                }
              },
              child: TextField(
                focusNode: focus1,
                cursorHeight: 30,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                style: const TextStyle(color: Colors.black, fontSize: 28),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                controller: otp3Controller,
                onChanged: (v) {
                  if (v != '') {
                    setState(() {
                      otp3Controller.text = v;
                    });
                    FocusScope.of(context).requestFocus(focus2);
                  } else {
                    setState(() {
                      otp3Controller.text = '';
                    });
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 14),

          // OTP Input 4
          SizedBox(
            height: 60,
            width: 60,
            child: RawKeyboardListener(
              focusNode: focus2Listner,
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.backspace &&
                    otp4Controller.text == '') {
                  FocusScope.of(context).requestFocus(focus1);
                }
              },
              child: TextField(
                focusNode: focus2,
                textAlign: TextAlign.center,
                cursorHeight: 30,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                style: const TextStyle(color: Colors.black, fontSize: 28),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                controller: otp4Controller,
                onChanged: (v) {
                  if (v != '') {
                    setState(() {
                      otp4Controller.text = v;
                    });
                    if (otp1Controller.text.isNotEmpty &&
                        otp2Controller.text.isNotEmpty &&
                        otp3Controller.text.isNotEmpty &&
                        otp4Controller.text.isNotEmpty) {
                      verifyOtp(context, AuthProvider(context), widget.otpToken);
                    }
                  } else {
                    setState(() {
                      otp4Controller.text = '';
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void verifyOtp(BuildContext context, AuthProvider authProvider, otpTOken) {
    if (otp1Controller.text.isNotEmpty &&
        otp2Controller.text.isNotEmpty &&
        otp3Controller.text.isNotEmpty &&
        otp4Controller.text.isNotEmpty) {
      var verificationCode = otp1Controller.text +
          otp2Controller.text +
          otp3Controller.text +
          otp4Controller.text;

      if (verificationCode.length == 4) {
        authProvider.verifyOtp(verificationCode, otpTOken,context);
      }
    }
  }
}
