import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../utils/app_routes.dart';

//Screen individual de cada item apos ser selecionado no Gridview
// chamado em screens/categories_meals_screen.dart
/*recebe cada meal individual mente por um índice, por este Widget está sendo chamado por um Listview.builder*/
class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({Key? key, required this.meal}) : super(key: key);

  void _selectMeal(BuildContext context) {
    //navega entre telas e envia um argumento meal para a rota MEAL_DETAILS(screens/meal_detail_screen.dart)
    //o then funciona aqui quando uma tela é fechada e um argumento é retornado de meal_detail_screen pela
    // função '() => Navigator.of(context).pop(meal.title)'
    Navigator.of(context).pushNamed(
      AppRoutes.MEAL_DETAILS,
      arguments: meal,
    );
/*        .then((result) => {
              if (result == null)
                {print('Sem resultado')}
              else
                {print('O nome da refeição é $result.')}
            });*/
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                //define as bordas de determinado componente
                ClipRRect(
                  //define a estilização das bordas
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),

                  // Inicia um widget de imagem com a imagem da refeição usando a URL da imagem
                  child: Image.network(
                    //caminho Url da imagem
                    meal.imageUrl,
                    // Define a altura da imagem como 250 pixels
                    height: 250,
                    // Define a largura da imagem como o tamanho máximo disponível

                    width: double.infinity,
                    // Define o modo de ajuste da imagem como "BoxFit.cover"
                    fit: BoxFit.cover,
                  ),
                ),
                //Widget de posicionamento
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      meal.title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      //quebras de linha para encaixar
                      softWrap: true,
                      //fade no texto
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        const SizedBox(
                          width: 6,
                        ),
                        Text('${meal.duration} min')
                      ],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.work),
                        const SizedBox(
                          width: 6,
                        ),
                        Text('${meal.complexityText} ')
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.monetization_on_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text('${meal.costText} ')
                      ],
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
