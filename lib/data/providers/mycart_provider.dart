import 'package:flutter/material.dart';
import 'package:hny_main/data/models/cart/cartlist_model.dart';
import 'package:hny_main/service/cart_service.dart';
import 'package:hny_main/core/utils/app_alerts.dart';

class MyCartProvider with ChangeNotifier {
  final MyCartService _cartService;
  List<ArrList> _cartItems = [];
  bool _isLoading = false;
  String? _error;

  MyCartProvider(BuildContext context) : _cartService = MyCartService(context);

  List<ArrList> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCartItems() async {
    _setLoading(true);
    _setError(null);

    try {
      final cartData = await _cartService.fetchMyCartList();
      if (cartData != null && cartData.arrList != null) {
        _cartItems = cartData.arrList!;
        notifyListeners();
      } else {
        _setError('Failed to fetch cart items');
      }
    } catch (e) {
      _setError('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      final response = await _cartService.deleteCartItem(cartItemId);
      if (response.success) {
        _cartItems.removeWhere((item) => item.id == cartItemId);
        await fetchCartItems();
        AppAlerts.showCustomSnackBar('Item removed from cart', isSuccess: true);
      } else {
        AppAlerts.showCustomSnackBar('Failed to remove item', isSuccess: false);
      }
    } catch (e) {
      AppAlerts.showCustomSnackBar('Error: $e', isSuccess: false);
    }
  }

  Future<void> updateCartItem({
    required String id,
    required int intCount,
    required DateTime strStartDate,
    required DateTime strEndDate,
    required List<double> strPickupLocation,
    required List<double> strDeliveryLocation,
    required String strPickupLocationAddress,
    required String strDeliveryLocationAddress,
  }) async {
    try {
      final data = {
        "_id": id,
        "intCount": intCount,
        "strStartDate": strStartDate.toIso8601String(),
        "strEndDate": strEndDate.toIso8601String(),
        "strPickupLocation": {
          "type": "Point",
          "coordinates": strPickupLocation,
        },
        "strDeliveryLocation": {
          "type": "Point",
          "coordinates": strDeliveryLocation,
        },
        "strPickupLocationAddress": strPickupLocationAddress,
        "strDeliveryLocationAddress": strDeliveryLocationAddress,
      };

      final response = await _cartService.updateCartItem(data);
      if (response.success) {
        await fetchCartItems(); // Refresh the cart items
        AppAlerts.showCustomSnackBar('Cart item updated successfully', isSuccess: true);
      } else {
        AppAlerts.showCustomSnackBar('Failed to update cart item', isSuccess: false);
      }
    } catch (e) {
      AppAlerts.showCustomSnackBar('Error: $e', isSuccess: false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    if (value != null) {
      notifyListeners();
    }
  }
}