import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/favourites/favourites_model.dart';
import 'package:hny_main/service/favourite_service.dart';

class FavouriteProvider extends ChangeNotifier {
  final FavouriteService _favouriteService;

  FavouriteProvider(BuildContext context)
      : _favouriteService = FavouriteService(context);

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<FavArrList> _favArrList = [];
  List<FavArrList> get favArrList => _favArrList;

  // Private Methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void _handleError(String message) {
    _setError(message);
    AppAlerts.showCustomSnackBar(message, isSuccess: false);
  }

  void _updateFavList(List<FavArrList> data) {
    _favArrList = data;
    notifyListeners();
  }

  Future<void> getFavouritesList() async {
    _setLoading(true);
    _setError(null);
    try {
      final data = await _favouriteService.getFavouritesList();
      if (data != null) {
        _updateFavList(data.arrList!);
      } else {
        _handleError("Failed to fetch favorites");
      }
    } catch (e) {
      _handleError("An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToFavourites(String strCarId) async {
    _setLoading(true);
    _setError(null);
    try {
      log('strCarId: $strCarId');

      final response = await _favouriteService.addToFavourites(strCarId);
      log('response: ${response.success}');
      if (response.success) {
        await getFavouritesList(); // Refresh the list
      } else {
        _handleError("Failed to add to favorites");
      }
    } catch (e) {
      _handleError("An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removeFromFavourites(String strCarId) async {
    _setLoading(true);
    _setError(null);
    try {
      log('strCarId: $strCarId');
      final response = await _favouriteService.removeFromFavourites(strCarId);
      if (response.success) {
        await getFavouritesList(); // Refresh the list
      } else {
        _handleError("Failed to remove from favorites");
      }
    } catch (e) {
      _handleError("An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }
}
