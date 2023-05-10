import 'package:application/models/meal.dart';
import 'package:flutter/material.dart';


//Widget com descrição de cada item selecionado no arquivo components/meal_item.dart
class MealDetailScreen extends StatelessWidget {

  //recebimento de parametro de main.dart que adicionará ou removerá uma refeição da lista de favoritos
  final Function(Meal) selectFavorite;

  final bool Function(Meal) isFavorite;

  MealDetailScreen({Key? key, required this.selectFavorite, required this.isFavorite}) : super(key: key);

  List<Icon> favIcon = [
    Icon(Icons.star),
    Icon(Icons.star_border_outlined),
  ];

  _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  _createSectionContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      width: 350,
      height: 260,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    //recebe argumentos de meal_item.dart
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              _createSectionTitle(context, 'Ingredientes'),
              _createSectionContainer(ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (_, index) {
                    return Card(
                      elevation: 3,
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(meal.ingredients[index]),
                      ),
                    );
                  })),
              _createSectionTitle(context, 'Passos'),
              _createSectionContainer(
                ListView.builder(itemCount: meal.steps.length,
                  itemBuilder: (_,index){
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index+1}'),
                          backgroundColor: Colors.pink,
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                  },)
              )
            ],
          ),
        )
    ,floatingActionButton: FloatingActionButton(
      child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
      onPressed: (){
        selectFavorite(meal);
      },
    ),);
  }
}
