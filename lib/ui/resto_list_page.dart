import 'package:provider/provider.dart';
import 'package:restaurants/provider/restaurant_list_provider.dart';
import 'package:restaurants/ui/resto_search.dart';
import 'package:restaurants/utils/result_state.dart';
import 'package:restaurants/widgets/card_restaurant.dart';
import 'package:restaurants/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestoListPage extends StatelessWidget {
  const RestoListPage({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardListRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return const Center(child: Text('Data Error!'));
        } else if (state.state == ResultState.error) {
          return const Center(
              child: Text('Data gagal di proses. silahkan cek internet anda!'));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchPage());
              })
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
        leading: Icon(Icons.search),
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
