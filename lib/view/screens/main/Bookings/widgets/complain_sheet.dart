import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_text_styles.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/file_upload_ui_widget.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:hny_main/view/widgets/app_textform_widget.dart';
import 'package:provider/provider.dart';

class ComplainBottomSheet extends StatelessWidget {
  ComplainBottomSheet({super.key});

  final TextEditingController _complainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Consumer<HomeController>(
          builder: (context, value, child) => Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 14, left: 20),
                child: Text(
                  'Add Complain',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
                width: double.infinity,
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      "Type",
                      style: AppTextStyles.subText,
                    ),
                    const Gap(6),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: const BoxDecoration(
                              color: AppColors.paymentScreenBackgroundColor,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1, 1),
                                    spreadRadius: 0.1,
                                    color: Color.fromARGB(255, 240, 240, 240),
                                    blurRadius: 15)
                              ]),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          AppColors.textFormFieldBorderColor)),
                              filled: true,
                              fillColor: AppColors.paymentScreenBackgroundColor,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "Feedback",
                                child: Text("Feedback"),
                              ),
                            ],
                            onChanged: (value) {
                              // Handle the selected value
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    const AppText(
                      "Description",
                      style: AppTextStyles.subText,
                    ),
                    const Gap(6),
                    Container(
                        decoration: const BoxDecoration(
                            color: AppColors.paymentScreenBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(1, 1),
                                  spreadRadius: 0.1,
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  blurRadius: 15)
                            ]),
                        child: CustomTextFormField(
                          controller: _complainController,
                          label: "",
                          hint: "",
                          borderColor: AppColors.textFormFieldBorderColor,
                        )),
                    const Gap(20),
                    const FileUploadUIWidget(),
                    const Gap(19),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.8,
                                  image: NetworkImage(
                                      "https://s3-alpha-sig.figma.com/img/88e1/9850/2263bb25c4afd1f816bc8ba87c793afc?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=WS3wTJsPdmY0KZ9jwOwDmZddw6LMcfTIKEwXbE3o96CdF6Gf84LwdCvdvvPvp1QCTZuLUsIJpGFWBUjj2fYBnUEWHF9O6KWozC6v4gOPX54pM~RDEDnL3mHSBTZCUqyCiZhpXh~vnip2p-EAMUwvx8VBAc8BW6-2hpKyC~jtsdwDNZVWa8ythN6cTIJtGs-Woa~Sz96uulsZXu77I9aPZREO9ATadty5j~5QOPpcxpdJZHWeaH2qYlzV1X5I8DV2ub4AgbqRaerCbqrwtc9Nyd1UrbzVBmMUO8HlLB~a0F3UjlLyolcMBHNx7ogsVI4dqV0Vcp5hevliXr8-5kH5Mg__"))),
                          width: 60,
                          height: 60,
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: AppColors.white,
                            size: 28,
                          ),
                        ),
                        const Gap(12),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.8,
                                  image: NetworkImage(
                                      "https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MNr-1-ttvxdgpVPX5N5hdXMgI2SqVIcsup33wbjLCDNXRiI75R4b6SWLoxXICJ2NkmkaA~~D~glvfMdPcWAxeSIT-HEQEWgJjkFK9KiM5kgxFdatRybD0dY7vBcBTncYhNmvSsFuGxdxdqentwLHmEmyma8GjsN0Z382-WIp2nXxauXXW4IvNLNNueHV92BaQvEQubh9LrgH2OGrYrnNHx8BdpGYjK1wDy11F8-58FjoZvRmFSS3ogodmv5B9dLYwxcWWIr5Z0OKNPxhmI3YBCClAyboC682IYz~eZSe5TxNnKks3k0lrwBAV9nEMJMk2kleItJ8zQpyotHpblJfjw__"))),
                          width: 60,
                          height: 60,
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: AppColors.white,
                            size: 28,
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
                          isGrey: true,
                          ontap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        PrimaryElevateButton(
                            ontap: () {
                              Navigator.pop(context);
                            },
                            buttonName: "Submit"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
