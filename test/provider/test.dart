import 'package:restaurants/data/model/list_resto.dart';
import 'package:flutter_test/flutter_test.dart';

var listRestaurant = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
  "pictureId": "25",
  "city": "Gorontalo",
  "rating": 4
};
void main() {
  test("Test Json", () async {
    var resultId = ListRestaurant.fromJson(listRestaurant).id;
    var resultName = ListRestaurant.fromJson(listRestaurant).name;
    var resultDescription = ListRestaurant.fromJson(listRestaurant).description;
    var resultPictureId = ListRestaurant.fromJson(listRestaurant).pictureId;
    var resultCity = ListRestaurant.fromJson(listRestaurant).city;
    var resultRating = ListRestaurant.fromJson(listRestaurant).rating;
    expect(resultId, "s1knt6za9kkfw1e867");
    expect(resultName, "Kafe Kita");
    expect(resultDescription,
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...");
    expect(resultPictureId, "25");
    expect(resultCity, "Gorontalo");
    expect(resultRating, 4);
  });
}
