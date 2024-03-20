import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/components/utils/custom_app_bar.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';

class CategoriesMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;

    final categoryMeals = dummyMeals.where((meal) {
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
