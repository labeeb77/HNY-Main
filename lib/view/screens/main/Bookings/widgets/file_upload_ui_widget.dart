import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';

class FileUploadUIWidget extends StatelessWidget {
  const FileUploadUIWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(4), // Rounded corners
      dashPattern: [4, 4], // Define the dot and gap lengths
      color: AppColors.primary, // Border color
      strokeWidth: 1.5, // Thickness of the border
      child: Container(
        width: MediaQuery.of(context).size.width - 40, // Adjust width

        decoration: const BoxDecoration(
          color: AppColors.greenShadeBackground, // Background color
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 19),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.file_upload_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
                Gap(6),
                Text(
                  "Upload your files here",
                  style: TextStyle(
                    color: Color(0xFF82868B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(6),
                Text(
                  "Brouse",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
