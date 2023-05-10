import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/app_routes.dart';

//Grid's do Gridview, que retorna um objeto clicável que permitirar acessar uma nova tela
//Chamado por screens/categories_screens.dart
class CategoryWidget extends StatelessWidget {

  //recebeu cada item de uma 'dummyCategories.map((cat)=> CategoryWidget(category: cat))'
  final Category category;

  const CategoryWidget({Key? key, required this.category})
      : super(key: key); //Constructor

  //função para navegação entre telas
  void _selectCategory(BuildContext context) {
/*    Navigator.of(context).push(
      MaterialPageRoute(builder: (_){
        return CategoriesMealsScrean();
      }),
    );*/

    //navegar entre as telas, enviando "category" como argumento para categories_meals_screen.dart
    Navigator.of(context)
        .pushNamed(AppRoutes.CATEGORIES_MEALS, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    //Inkwell permite tornar o Grid sensivel ao toque, e executar uma ação ao faze-lo
    return InkWell(
      //define a função de navegação para uma proxima tela
      onTap: () => _selectCategory(context),
      borderRadius: BorderRadius.circular(20),
      splashColor: Theme.of(context).primaryColor, //click color
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.5),
            category.color,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
            child: Text(
          //seleciona o titulo a partir do objeto recebido pelo map
          category.title,
          //seleciona o estilo geral definido no ThemeData no main.dart
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black54,
              ),
        )),
      ),
    );
  }
}
