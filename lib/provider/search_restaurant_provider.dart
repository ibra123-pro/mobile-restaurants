import 'dart:async';

import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/data/model/search_resto.dart';
import 'package:flutter/material.dart';
import 'package:restaurants/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late SearchRestaurantResult? _restaurantsResult;
  String _message = '';
  String _query = '';
  late ResultState _state;

  String get message => _message;
  String get query => _query;

  SearchRestaurantResult? get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      _query = query;

      final restaurantsrc = await apiService.searchRestaurant(query);
      if (restaurantsrc.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurantsrc;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return 'Error --> $e';
    }
  }
}
