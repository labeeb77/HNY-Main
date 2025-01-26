import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/helpers/route_arguments.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_spacing.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key, required this.args});

  final NoInternetArguments args;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Replace with your image asset or SVG icon
          AppSpacingWidgets.sbh20,
          const Icon(
            Icons.cloud_off,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Text(
            "Oops, No Internet Connection",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Make sure Wi-Fi or cellular data is turned on and then try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          AppSpacingWidgets.sbh20,
          ElevatedButton(
            onPressed: () => checkInterNet(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white, // Button color
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "TRY AGAIN",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkInterNet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult[0] == ConnectivityResult.none) {
      // Log and return an error if there is no internet connection
      AppAlerts.appToast("No internet connection", color: Colors.red);
    } else {
      args.onRetry();
    }
  }
}

void showNoInternetDialog(BuildContext context, NoInternetArguments args) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing the dialog by tapping outside
    builder: (BuildContext context) {
      return NoInternetScreen(args: args);
    },
  );
}
