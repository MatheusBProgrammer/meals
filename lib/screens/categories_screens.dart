import 'package:flutter/material.dart';
import '../components/category_widget.dart';
import '../data/dummy_data.dart';


//Pagina inicial que exibe uma GridView clicáveis de refeições (obs: o InkWell está no CategoryWidget(category_widget))
//exibido por screens/tabs_screen.dart
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200 /*size*/,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: dummyCategories.map((cat) {
            //passa uma lista com cada componente individual para o componente em components/category_widgets.dart
            return CategoryWidget(category: cat);
          }).toList(),
    );
  }
}
