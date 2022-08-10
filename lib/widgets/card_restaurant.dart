import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/data/model/list_resto.dart';
import 'package:restaurants/provider/database_provider.dart';
import 'package:restaurants/ui/resto_detail_page.dart';

class CardListRestaurant extends StatelessWidget {
  final ListRestaurant restaurant;

  const CardListRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavoritesd(restaurant.id),
        builder: (context, snapshot) {
          return Material(
            color: primaryColor,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  ApiService.baseUrlImage + restaurant.pictureId,
                  width: 100,
                ),
              ),
              title: Text(
                'Restaurant ${restaurant.name}',
              ),
              subtitle: Text(restaurant.city),
              trailing: Text('${restaurant.rating}'),
              isThreeLine: true,
              onTap: () => Navigator.pushNamed(
                context,
                RestaurantDetailPage.routeName,
                arguments: restaurant,
              ),
            ),
          );
        },
      );
    });
  }
}
