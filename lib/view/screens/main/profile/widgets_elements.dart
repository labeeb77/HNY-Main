
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class GeneralElementContainer extends StatelessWidget {
  final title;
  final leadingIcon;
  final isDelete;
  const GeneralElementContainer({

    super.key, this.title, this.leadingIcon,this.isDelete = false
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(leadingIcon,size: 28,color: isDelete?AppColors.orange:AppColors.black,),
        const Gap(20),
        AppText(title,fontWeight: FontWeight.w600,color: isDelete?AppColors.orange:AppColors.black,),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDelete?AppColors.orange: AppColors.iconGrey,
        )
      ],
    );
  }
}

class DocumentElement extends StatelessWidget {
  final docName;
  final docIcon;
  const DocumentElement({
    super.key,
    this.docName,
    this.docIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 103,
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  color:
                      const Color.fromARGB(255, 220, 218, 218).withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 5,
                  offset: const Offset(1, 1))
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Icon(
              docIcon,
              color: AppColors.primary,
              size: 35,
              weight: 0.5,
            ),
            const Spacer(),
            AppText(
              docName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ));
  }
}
