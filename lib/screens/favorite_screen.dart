import 'package:application/components/meal_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  //recebido de tabs.screen por parâmetro
  final List<Meal> favoriteMeals;

  const FavoriteScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('Nenhum favorito adicionado ainda!'),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (_, index) {
          return MealItem(meal: favoriteMeals[index]);
        },
      );
    }
  }
}
