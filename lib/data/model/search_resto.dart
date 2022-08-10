import 'package:restaurants/data/model/list_resto.dart';

class SearchRestaurantResult {
  SearchRestaurantResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<ListRestaurant> restaurants;

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<ListRestaurant>.from(
            json["restaurants"].map((x) => ListRestaurant.fromJson(x))),
      );
}
