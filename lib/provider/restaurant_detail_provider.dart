import 'dart:async';

import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/data/model/detail_resto.dart';
import 'package:flutter/material.dart';
import 'package:restaurants/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  final String restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchAllRestaurant();
  }

  late RestaurantDetailResult _restaurantsResult;
  late ResultState _state;
  final String _message = '';

  RestaurantDetailResult get result => _restaurantsResult;

  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantdl = await apiService.detailRestaurant(restaurantId);
      if (restaurantdl.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _restaurantsResult.restaurant.id = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurantdl;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return 'Error --> $e';
    }
  }
}
