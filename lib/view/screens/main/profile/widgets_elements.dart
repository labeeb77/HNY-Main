import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GeneralElementContainer extends StatelessWidget {
  final title;
  final leadingIcon;
  final isDelete;
  const GeneralElementContainer(
      {super.key, this.title, this.leadingIcon, this.isDelete = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          leadingIcon,
          size: 28,
          color: isDelete ? AppColors.orange : AppColors.black,
        ),
        const Gap(20),
        AppText(
          title,
          fontWeight: FontWeight.w600,
          color: isDelete ? AppColors.orange : AppColors.black,
        ),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDelete ? AppColors.orange : AppColors.iconGrey,
        )
      ],
    );
  }
}

class DocumentElement extends StatelessWidget {
  final docName;
  final docIcon;
  final argument;
  final String? imageUrl;
  final String routeName;
  final bool isEnabled;
  const DocumentElement({
    super.key,
    required this.routeName,
    this.docName,
    this.argument,
    this.docIcon,
    this.imageUrl,
    this.isEnabled = true,
  });

  // void _showImageDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       child: Container(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             CachedNetworkImage(
  //               imageUrl: imageUrl!,
  //               placeholder: (context, url) => const CircularProgressIndicator(),
  //               errorWidget: (context, url, error) => const Icon(Icons.error),
  //               fit: BoxFit.contain,
  //             ),
  //             const SizedBox(height: 16),
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('Close'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(routeName, arguments: argument);
        },
        // isEnabled && imageUrl != null ? () => _showImageDialog(context) : null,
        child: Container(
          height: 103,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 220, 218, 218).withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 5,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Icon(
                docIcon,
                color: isEnabled ? AppColors.primary : AppColors.iconGrey,
                size: 35,
                weight: 0.5,
              ),
              const Spacer(),
              AppText(
                docName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isEnabled ? AppColors.black : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
