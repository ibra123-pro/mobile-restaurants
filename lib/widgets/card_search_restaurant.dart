import 'package:flutter/material.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/data/model/list_resto.dart';
import 'package:restaurants/ui/resto_detail_page.dart';

class CardRestaurantSearchPage extends StatelessWidget {
  final ListRestaurant? restaurantSearchItems;
  const CardRestaurantSearchPage(
      {Key? key, required this.restaurantSearchItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurantSearchItems!.pictureId,
          child: Image.network(
            ApiService.baseUrlImage + restaurantSearchItems!.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurantSearchItems!.name,
        ),
        subtitle: Text(restaurantSearchItems!.city),
        trailing: Text('${restaurantSearchItems!.rating}'),
        onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurantSearchItems,
        ),
      ),
    );
  }
}
