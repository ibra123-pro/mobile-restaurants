class ListRestaurantResult {
  ListRestaurantResult({
    required this.error,
    required this.status,
    required this.totalResults,
    required this.restaurants,
  });

  bool error;
  String status;
  int totalResults;
  List<ListRestaurant> restaurants;

  factory ListRestaurantResult.fromJson(Map<String, dynamic> json) =>
      ListRestaurantResult(
        error: json["error"],
        status: json["message"],
        totalResults: json["count"],
        restaurants: List<ListRestaurant>.from(
            json["restaurants"].map((x) => ListRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": status,
        "count": totalResults,
        "restaurant": restaurants,
      };
}

class ListRestaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  ListRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: double.parse(json["rating"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
