import 'package:cantcook/widgets/background.dart';
import 'package:cantcook/widgets/customText.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/recipeTile.dart';

class RecipePage extends StatefulWidget {
  List<Recipe> recipes;
  RecipePage({
    required this.recipes,
    super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Background(
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: const CustomText(
              text: 'With the scanned items you can make',
              bold: true,
              size: 17,
              center: true
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.65,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: GestureDetector(
              child: ListView.builder(
                itemCount: widget.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = widget.recipes[index];
                  return RecipeTile(recipe: recipe);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}