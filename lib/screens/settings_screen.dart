import 'package:flutter/material.dart';
import '../components/drawer_main.dart';
import '../models/settings.dart';

//Screen de configurações de seleção de comida
//instanciado em main.dart e chamado em components/drawer_main.dart
class SettingsScreen extends StatefulWidget {

  //parametro recebido de main.dart
  final Settings settings;

  //parametro recebido de main.dart com uma função que filtra um objeto Settings para saber se respeita as validações
  //de Gluten, Lactose, Vegano e Vegetariano
  final Function(Settings) onSettingsChanged;


  const SettingsScreen({Key? key, required this.onSettingsChanged, required this.settings}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  //instancia do Objeto Settings
  late Settings settings;



  //initState utilizado para:
  //carregar os dados do settings a partir do parâmetro Setting recebido de main.dart
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settings = widget.settings;
  }

  //Widget Switch para ser chamado mais a frente no código
  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {//Widget que cria um switch que muda seu estado de acordo com o valor boleano representado em 'value', que muda de valor
    // na função OnChanged do mesmo Widget
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value){
        onChanged(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configurações',
        ),
        centerTitle: true,
      ),
      //Drawer que possibilita retorno
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _createSwitch('Sem Glùten', 'Exibirá apenas refeições sem Glúten',
                  settings.isGlutenFree, (value) => setState(() => settings.isGlutenFree = value)),
              _createSwitch('Sem Lactose', 'Exibirá apenas refeições sem Lactose',
                  settings.isLactoseFree, (value) => setState(() => settings.isLactoseFree = value)),
              _createSwitch('Vegano', 'Exibirá apenas Veganas',
                  settings.isVegan, (value) => setState(() => settings.isVegan = value)),
              _createSwitch('Vegetariano', 'Exibirá apenas refeições Vegetarianas',
                  settings.isVegetarian, (value) => setState(() => settings.isVegetarian = value)),
            ],
          ))
        ],
      ),
    );
  }
}
