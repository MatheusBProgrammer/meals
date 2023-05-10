import 'package:flutter/material.dart';


//classe modelo para as Categorias de alimento na aplicação
class Category{
  final String id;
  final String title;
  final Color color;

  const Category({required this.id, required this.title, this.color = Colors.orange});
}