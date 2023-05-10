import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'categories_screens.dart';
import 'favorite_screen.dart';
import '../components/drawer_main.dart';

//HomeScreen que seleciona as Categorias e os Favoritos
class TabScreen extends StatefulWidget {
  //recebe a lista que sera passada para screens/favorite_screen através do widget FavoriteScreen
  final List<Meal> favorite;

  const TabScreen({Key? key, required this.favorite}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

//state
class _TabScreenState extends State<TabScreen> {
  //indice que poderá ser modificado via _selectScreen()
  int _selectedScreenIndex = 0;

  //lista de Widgets que apresentarão uma tela de acordo com o índice selecionado
  //será inicializado no initState para carregar o widget.favorite posteriormente
  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'title': 'Lista de Categorias',
        'screen': CategoriesScreen(),
      },
      {
        'title': 'Menu de Favoritos',
        'screen': FavoriteScreen(
          favoriteMeals: widget.favorite,
        )
      }
    ];
  }

  //função para mudar o indice que seleciona uma tela da lista _screens
  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_screens[_selectedScreenIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      //_screens utiliza um dos objetos de um Map para criar uma tela, variando de acordo com a função _selectedScreenIndex.
      /*A função _selectedScreen reconhece qual Scaffold retornar devido ao SetState que ao ser selecionado
      muda o index do _selectedScreenIndex*/
      //'screen' seleciona qual tela do Map será utilizada
      //'as Widget' para utilizar o objeto do Map como Widget
      body: _screens[_selectedScreenIndex]['screen'] as Widget,
      //cria um barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        //Ao ser clicado ele muda o índex que seleciona a tela no _screens
        onTap: _selectScreen,
        backgroundColor: Colors.deepOrange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        //seleciona o index do objeto selecionado
        currentIndex: _selectedScreenIndex,
        //ao selecionar a Aba ele cria um pequeno avanço para destacar o item selecionado após o clique
        type: BottomNavigationBarType.shifting,
        items: const [
          //item 1 da BottomNavigationBar
          BottomNavigationBarItem(
            backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),

          //item 2 da BottomNavigationBar
          BottomNavigationBarItem(
            backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.star),
            label: 'Favoritos',
          )
        ],
      ),
    );
  }
}

//TabBar Superior da página inicial e favoritos
/*class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        //define qual Tab sera iniciada por padrão
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Vamos Cozinhar?'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.category),
                  text: 'Categorias',
                ),
                Tab(
                  icon: Icon(Icons.category),
                  text: 'Favoritos',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CategoriesScreen(),
              FavoriteScreen (),
            ],
          ),
        ));
  }
}*/
