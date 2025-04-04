import 'package:flutter/material.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
        appBar: CommonAppBar(
            title: 'My Cart',
          ),
    );
  }
}