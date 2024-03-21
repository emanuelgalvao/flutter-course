import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/components/custom_app_bar.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {

  final List<Meal> meals;

  CategoriesMealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: customAppBar(context, category.title),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (context, index) => MealItem(meal: categoryMeals[index]),
      ),
    );
  }
}
