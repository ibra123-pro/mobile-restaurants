import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_list_resto_service.dart';
import 'package:restaurants/data/model/detail_resto.dart';
import 'package:restaurants/data/model/list_resto.dart';
import 'package:restaurants/provider/database_provider.dart';

class CardDetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final ListRestaurant listrestaurant;

  const CardDetailRestaurant(
      {Key? key, required this.restaurant, required this.listrestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavoritesd(restaurant.id),
            builder: (context, snapshot) {
              var isFavoritesd = snapshot.data ?? false;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Restaurant App'),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(
                              ApiService.baseUrlImage + restaurant.pictureId)),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            isFavoritesd == true
                                ? IconButton(
                                    onPressed: () => provider
                                        .removeFavorite(listrestaurant.id),
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ))
                                : IconButton(
                                    onPressed: () =>
                                        provider.addFavorite(listrestaurant),
                                    icon: const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.red,
                                    )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Restaurant ${restaurant.name}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: const [
                                    Icon(Icons.location_on),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  restaurant.city,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: const [
                                    Icon(Icons.star),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${restaurant.rating}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Deskripsi',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              restaurant.description,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Daftar Makanan :',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                    '- ${restaurant.menus.foods[index].name}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Daftar Minuman :',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                    '- ${restaurant.menus.drinks[index].name}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Kategori Restaurant :',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.categories.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                    '- ${restaurant.categories[index].name}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Review Costumer :',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.customerReviews.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                    restaurant.customerReviews[index].name),
                                subtitle: Text(
                                    restaurant.customerReviews[index].review),
                                trailing: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Text(restaurant
                                        .customerReviews[index].date)),
                                isThreeLine: true,
                                //
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
