import 'package:hny_main/data/providers/auth_provider.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/data/providers/bottom_nav_controller.dart';
import 'package:hny_main/data/providers/common_provider.dart';
import 'package:hny_main/data/providers/favourite_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/data/providers/mycart_provider.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderSetup {
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(
        create: (context) => BottomNavController(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeController(context),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(context),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CommonProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => BookingProvider(context),
      ),
       ChangeNotifierProvider(
        create: (context) => FavouriteProvider(context),
      ),
      ChangeNotifierProvider(
        create: (context) => MyCartProvider(context),
      )
    ];
  }
}
