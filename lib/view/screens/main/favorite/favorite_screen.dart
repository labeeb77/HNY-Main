import 'package:flutter/material.dart';
import 'package:hny_main/data/providers/favourite_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
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
            return  const Center(child: Text('No favorites found'));
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
                  favouriteProvider
                      .removeFromFavourites(data[index].id ?? '0');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
