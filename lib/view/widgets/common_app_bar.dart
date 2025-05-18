
import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/back_button.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
final showLeading;
  final title;
  final showBorder;
  final List<Widget> actions;
  final bool goToHome;
  const CommonAppBar({
this.showLeading = true,
this.goToHome = false,
    super.key,required this.title, this.showBorder = false,  this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.background,
      leading: showLeading? CommonBackButton(
        showBorder: showBorder,
        goToHome: goToHome,
      ):const SizedBox(),
      title:  Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      scrolledUnderElevation: 0.0,
      elevation: 0,
      actions: actions,
    );
  }
}
