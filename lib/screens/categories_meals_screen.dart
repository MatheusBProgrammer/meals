import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../components/meal_item.dart';
import '../models/meal.dart';

//Tela de exibição de cada componente individual do GridView
class CategoriesMealsScrean extends StatelessWidget {

  //recebe o _availableMeals do main.dart
  final List<Meal> meals;

  const CategoriesMealsScrean({Key? key, required this.meals}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //receber argumentos de category_widget.dart sem receber diretamente um parâmetro
    final category = ModalRoute.of(context)?.settings.arguments as Category;

    /*selecionar a lista de refeições uma a uma e as colocar dentro de uma lista ( toList() );*/
    /*percorre a lista usando where, verifica cada objeto Meal individualmente e
    *  verifica se a instancia categories contém um id do objeto category recebido*/
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: categoryMeals[index]);
        },
      ),
    );
  }
}
