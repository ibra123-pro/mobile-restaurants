import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/provider/search_restaurant_provider.dart';
import 'package:restaurants/utils/result_state.dart';
import 'package:restaurants/widgets/card_search_restaurant.dart';

class SearchPage extends SearchDelegate<RestaurantSearchProvider> {
  @override
  Widget buildResults(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService())
        ..fetchAllRestaurant(query),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          } else if (query.length < 3) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text("Maaf"),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text("Pencarian data restaurant kurang dari 3 kata"),
                ),
              ],
            );
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurantItem = state.result!.restaurants[index];
                return CardRestaurantSearchPage(
                    restaurantSearchItems: restaurantItem);
              },
            );
          } else if (state.state != ResultState.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text("Maaf"),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Pencarian data tidak ditemukan!",
                  ),
                ),
              ],
            );
          } else if (query.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text("Maaf"),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Data kosong silahkan diisi!",
                  ),
                )
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text(""),
                )
              ],
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Center(
          child: Text("Masukkan kata kunci minimal"),
        ),
        Center(
          child: Text("3 kata data restaurant"),
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
