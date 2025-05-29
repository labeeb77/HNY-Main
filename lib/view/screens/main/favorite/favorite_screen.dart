import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/data/providers/bottom_nav_controller.dart';
import 'package:hny_main/data/providers/favourite_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavouriteProvider>(context, listen: false)
          .getFavouritesList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(
        title: "My Favorites",
        showBorder: true,
        showLeading: false,
      ),
      body: Consumer<FavouriteProvider>(
        builder: (context, favouriteProvider, child) {
          if (favouriteProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (favouriteProvider.error != null) {
            return Center(child: Text(favouriteProvider.error!));
          }
          if (favouriteProvider.favArrList.isEmpty) {
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No Favorites Yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your favorite cars will appear here. Start exploring and add some cars to your favorites!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                        child: PrimaryElevateButton(
                      buttonName: "Explore Cars",
                      ontap: () {
                        Provider.of<BottomNavController>(context, listen: false)
                            .changeScreenIndex(0);
                      },
                    )),
                  ],
                ),
              ),
            );
            ;
          }

          final data = favouriteProvider.favArrList;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: buildFavCarCard(
                data[index],
                data[index].carData?.strModel ?? "Unknown",
                data[index].carData?.intRating.toString() ?? '4.0',
                data[index].carData?.strCarCategory ?? "Unknown",
                'Manual',
                data[index].carData?.intFuelCapacity ?? 0.0,
                '${data[index].carData?.strSeatNo} Seats',
                data[index].carData?.intPricePerDay.toString() ?? '0',
                data[index].carData?.strImgUrl ?? '',
                true,
                context,
                MediaQuery.of(context).orientation,
                mediaQuery,
                onFavoriteTap: () {
                  final homeProvider = Provider.of<HomeController>(context,listen: false);
                  favouriteProvider.removeFromFavourites(data[index].id).then((_) {
                                              homeProvider.getCarDataList(
                                                  context: context,
                                                  startDate:
                                                      homeProvider.selecteStratdDate,
                                                  endDate:
                                                      homeProvider.selecteEnddDate);
                });}
              ),
            ),
          );
        },
      ),
    );
  }
}
