import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:hny_main/view/screens/main/auth/sign_in_screen.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_textform_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow space for the keyboard
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Make the screen scrollable when the keyboard is shown
          child: InkWell(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Logo
                  SizedBox(
                    height: 86,
                    child: Image.asset("assets/logo/auth_screen_logo.png"),
                  ),
                  const SizedBox(height: 50),
                  // Welcome Text
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '👋 ,',
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignInScreen();
                      }));
                    },
                    child: const Text(
                      'Sign up to your account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Phone Number Input
                  Row(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '971',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                          child: CustomTextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _phoneNumberController,
                              label: "",
                              hint: "")),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You will receive an sms verification code that may apply messages and data rates',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: PrimaryElevateButton(
                      buttonName: "Next",
                      ontap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNav(),
                          ),
                          (route) => true,
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
