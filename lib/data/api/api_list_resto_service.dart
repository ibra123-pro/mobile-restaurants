import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurants/data/model/list_resto.dart';
import 'package:restaurants/data/model/detail_resto.dart';
import 'package:restaurants/data/model/search_resto.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/large/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search';

  Future<ListRestaurantResult> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Menampilkan List Restaurant');
    }
  }

  Future<RestaurantDetailResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Menampilkan Detail Restaurant');
    }
  }

  Future<SearchRestaurantResult> searchRestaurant(String text) async {
    final response = await http.get(Uri.parse("$_baseUrl$_search?q=$text"));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Menampilkan Pencarian Restaurant');
    }
  }
}
