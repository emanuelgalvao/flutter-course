import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  const FavoritesScreen(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return _favoriteMeals.isEmpty
        ? const Center(
            child: Text('Nenhuma receita favoritada!'),
          )
        : ListView.builder(
            itemCount: _favoriteMeals.length,
            itemBuilder: (context, index) {
              return MealItem(meal: _favoriteMeals[index]);
            },
          );
  }
}
