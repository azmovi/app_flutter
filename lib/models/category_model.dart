import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });
  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: 'Salad',
        iconPath: 'assets/icons/salad.svg',
        boxColor: Colors.purple,

      )
    );

    categories.add(
      CategoryModel(
        name: 'pancake',
        iconPath: 'assets/icons/cake.svg',
        boxColor: Colors.blue,

      )
    );

    categories.add(
      CategoryModel(
        name: 'Pie',
        iconPath: 'assets/icons/pie.svg',
        boxColor: Colors.orange,

      )
    );

    categories.add(
      CategoryModel(
        name: 'Smoothies',
        iconPath: 'assets/icons/smoothies.svg',
        boxColor: Colors.pink,

      )
    );

    return categories;
  }
}
