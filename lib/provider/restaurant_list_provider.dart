import 'dart:async';

import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/data/model/list_resto.dart';
import 'package:flutter/material.dart';
import 'package:restaurants/utils/result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late ListRestaurantResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurantResult get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restauranls = await apiService.listRestaurant();
      if (restauranls.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restauranls;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
