import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/provider/database_provider.dart';
import 'package:restaurants/utils/result_state.dart';
import 'package:restaurants/widgets/card_restaurant.dart';
import 'package:restaurants/widgets/platform_widget.dart';

class RestoFavoritePage extends StatelessWidget {
  const RestoFavoritePage({Key? key}) : super(key: key);
  static const String favoritesTitle = 'Favorite';

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
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
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              var restaurant = state.favorites[index];
              return CardListRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return const Center(child: Text('Data favorite kosong'));
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
        title: const Text('Favorite'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorite'),
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
