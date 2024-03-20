import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/utils/app_routes.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  MealItem({
    required this.meal,
  });

  void _onMealSelected(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.MEAL_DETAILS,
      arguments: meal
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onMealSelected(context),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        elevation: 4,
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  meal.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 20,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Text(
                    meal.title,
                    style: const TextStyle(fontSize: 26, color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.schedule),
                    const SizedBox(width: 6),
                    Text('${meal.duration} min')
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.work),
                    const SizedBox(width: 6),
                    Text(meal.complexityText)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_money),
                    const SizedBox(width: 6),
                    Text(meal.costText)
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
