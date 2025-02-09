import 'package:flutter/material.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(
        title: "My Favorites",
        showBorder: true,
        showLeading: false,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => Consumer<HomeController>(builder: (context, value, child) {
             final data = value.carListData;
          return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            child: buildCarCard(
              data[index],
                'Toyota Corolla',
                4.8.toString(),
                'Sedans',
                'Manual',
                'Petrol',
                '5 Seats',
                '7,000',
                data[index].strImgUrl ?? '',
                true,
                context,
                orientation,
                mediaQuery),
          ),
        );
        },)
      ),
    );
  }
}
