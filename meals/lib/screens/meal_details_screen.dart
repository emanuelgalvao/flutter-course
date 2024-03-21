import 'package:flutter/material.dart';
import 'package:meals/components/custom_app_bar.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {

  final Function (Meal) _onFavorited;
  final Function (Meal) _isFavorite;

  const MealDetailsScreen(this._onFavorited, this._isFavorite);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _createSectionContent({required Widget child}) {
    return Container(
      height: 250,
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar: customAppBar(context, meal.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(meal.imageUrl),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContent(
              child: ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (_, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            _createSectionTitle(context, 'Passos'),
            _createSectionContent(
                child: ListView.builder(
              itemCount: meal.steps.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    const Divider()
                  ],
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFavorited(meal),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        child: Icon(_isFavorite(meal) ? Icons.favorite : Icons.favorite_outline),
      ),
    );
  }
}
