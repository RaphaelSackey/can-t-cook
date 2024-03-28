import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:cantcook/pages/recipe_page.dart';
import 'package:cantcook/pages/take_picture.dart';
import 'package:cantcook/widgets/background.dart';
import 'package:cantcook/widgets/customButton.dart';
import 'package:cantcook/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../utils/sharedPrefs.dart';

class ScannedPage extends StatefulWidget {
  final String prediction;
  final String imagePath;
  final CameraDescription camera;
  const ScannedPage({
    required this.prediction,
    required this.camera,
    required this.imagePath,
    super.key});

  @override
  State<ScannedPage> createState() => _ScannedPageState();
}

class _ScannedPageState extends State<ScannedPage> {

  bool isExist = false;
  List<String> recipesList = [];

  @override
  void initState() {
    super.initState();
    isExist = ingredients.contains(widget.prediction);
    if(!isExist){
      ingredients.add(widget.prediction);
    }
  }


  Future<http.Response?> sendIngredients(List<String> ingredients) async {
    final Uri uri = Uri.parse("http://127.0.0.1:5000/recipe");
    final List<String> ingredientList = ingredients;

    try {
      print(jsonEncode({"ingredients": ingredientList}));
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"ingredients": ingredientList}),
      );

      return response;

    } catch (e) {
      print("Error: $e");
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size. width * 0.8,
      duration: const Duration(seconds: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)),
      content: CustomText(text:'Could not Connect to Backend!', size: 18, color: Colors.white, space: 1),
      backgroundColor:Colors.red,
    );
    return Background(
      widget: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const CustomText(
                text: 'You have scanned: ',
                bold: true,
                size: 20,
              ),
              const SizedBox(
                height: 15,
              ),
              Image.file(
                  File(widget.imagePath),
                  width: 80,
              ),
              const SizedBox(
                height: 15,
              ),
              isExist ? Column(
                children: [
                  CustomText(
                    text: 'You already have: ${widget.prediction}',
                    bold: true,
                    size: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ) : SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = ingredients[index];

                    return Column(
                      children: [
                        Container(
                          width: 307,
                          height: 48,
                          padding: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ingredient,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    ingredients.removeAt(index);
                                    setState(() {
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete_forever_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () async {
                  try{
                    var response = await sendIngredients(ingredients);
                    if (response?.statusCode == 200) {
                      print("Request successful");
                      List<dynamic> recipeData = json.decode(response!.body);

                      List<Recipe> recipesList = recipeData.map((json) => Recipe.fromJson(json)).toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            RecipePage(
                              recipes: recipesList,
                        )),
                      );
                    } else {
                      print("Request failed");
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  } catch (e){
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                text: 'Continue',
              ),
              const SizedBox(
                height: 27,
              ),
              CustomButton(
                onPressed: () async {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TakePictureScreen(
                        camera: widget.camera,
                      ),
                    ),
                  );
                },
                text: 'Add more',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
