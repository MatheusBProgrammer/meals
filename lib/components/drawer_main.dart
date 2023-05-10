import 'package:flutter/material.dart';
import '../utils/app_routes.dart';

//Menu Drawer chamado no arquivo screens/tabs_screen.dart
class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _createItem(IconData icon, String label, VoidCallback navigate) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(icon, size: 26),
          title: Text(
            label,
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          onTap: navigate,
        ),
        Divider(), // This is your Divider
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.bottomRight,
            child: Text(
              'Vamos Cozinhar?',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _createItem(Icons.restaurant, 'Refeições',
              //essa maneira de navegar substitui uma tela ao invés de utilizar um padrão de empilhamento de telas.//
              //dessa maneira, utiliza melhor os recursos do dispositivo e obtem melhor perfomance.
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)),
          _createItem(
            Icons.settings,
            'Configurações',
            () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.SETTINGS),
          )
        ],
      ),
    );
  }
}
