import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/validators.dart';
import 'package:hny_main/data/providers/auth_provider.dart';
import 'package:hny_main/view/screens/main/auth/otp_verify_screen.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_textform_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

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
                  Form(
                      key: _formKey,
                      child: _buildPhoneNumberInput(
                          Validators.validatePhoneNumber)),
                  const SizedBox(height: 16),
                  Text(
                    'You will receive an SMS verification code that may apply messages and data rates.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    textAlign: TextAlign.center,
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
                          _handleLogin(
                            context,
                            AuthProvider(),
                          );
                        }
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

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Text('👋 ,', style: TextStyle(fontSize: 32)),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to your account',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberInput(
    String? Function(String?)? validator,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('971', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomTextFormField(
            validator: validator,
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            label: "Phone Number",
            hint: "Enter your phone number",
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogin(
      BuildContext context, AuthProvider authProvider) async {
    final otpToken = await authProvider.login(
      _phoneNumberController.text,
    );

    if (!context.mounted) return;

    if (otpToken is String && otpToken.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => OtpVerifyScreen(
                  otpToken: otpToken,
                )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'Login failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
