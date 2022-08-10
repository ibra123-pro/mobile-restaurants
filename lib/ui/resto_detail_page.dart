import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/data/model/list_resto.dart';
import 'package:flutter/material.dart';
import 'package:restaurants/provider/restaurant_detail_provider.dart';
import 'package:restaurants/utils/result_state.dart';
import 'package:restaurants/widgets/card_detail_restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final ListRestaurant listrestaurant;

  const RestaurantDetailPage({Key? key, required this.listrestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            restaurantId: listrestaurant.id, apiService: ApiService()),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return CardDetailRestaurant(
                restaurant: state.result.restaurant,
                listrestaurant: listrestaurant,
              );
            } else if (state.state == ResultState.noData) {
              return const Center(child: Text('Data Error!'));
            } else if (state.state == ResultState.error) {
              return const Center(
                  child: Text(
                      'Data gagal di proses. silahkan cek internet anda!'));
            } else {
              return const Scaffold(body: Center(child: Text('')));
            }
          },
        ),
      ),
    );
  }
}
