import 'package:application/models/settings.dart';
import 'package:application/screens/meal_detail_screen.dart';
import 'package:application/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';
import 'utils/error_screen.dart';
import 'screens/tabs_screen.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //instancia o settings na propria aplicação, para ser passado como parametro para screens/settings_screen.dart
  Settings settings = Settings();

  List<Meal> _availableMeals = dummyMeals;

  List<Meal> _favoriteMeals = [];

  // compara as propriedades de cada Meal com as configurações fornecidas
  // e mantém apenas aquelas refeições que atendem aos critérios especificados.
  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }
  /*alterna se uma comida foi selecionada ou não, caso ela nao tenha sido adcionara, ele adiciona à lista _favoriteMeals, caso contrário
  ele remove.*/
  void _selectFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal){
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //estilização geral
      theme: ThemeData(
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        //definição dos temas gerais da aplicação
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge:
                  const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
            .copyWith(secondary: Colors.deepOrange),
      ),
      //home: CategoriesScreen(),

      //rota inicial
      initialRoute: '/',

      //definição de rotas para navegação, utilizando o App.Routes para evitar erros de digitação no código
      routes: {
        AppRoutes.HOME: (_) => TabScreen(
              favorite: _favoriteMeals,
            ),
        AppRoutes.CATEGORIES_MEALS: (_) => CategoriesMealsScrean(
              meals: _availableMeals,
            ),
        AppRoutes.MEAL_DETAILS: (_) =>
            MealDetailScreen(selectFavorite: _selectFavorite,isFavorite: _isFavorite),
        AppRoutes.SETTINGS: (_) => SettingsScreen(
              settings: settings,
              onSettingsChanged: _filterMeals,
            )
      },

      //metodo de definição de uma rota padrão, em caso de erros
/*      onGenerateRoute: (settings) {
        if(settings.name == 'something'){
          return null;
        } else if(settings.name == 'something-else'){
          return null;
        } else {
          return MaterialPageRoute(builder: (_){
            return const CategoriesScreen();
          });
        }
      },*/

      //metodo de definição de uma rota padrão, em caso de erros
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) {
          return Error();
        });
      },
    );
  }
}
