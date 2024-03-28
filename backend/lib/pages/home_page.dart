import 'package:cantcook/pages/take_picture.dart';
import 'package:cantcook/utils/sharedPrefs.dart';
import 'package:cantcook/widgets/background.dart';
import 'package:cantcook/widgets/customButton.dart';
import 'package:cantcook/widgets/customText.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Background(
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const InstructPage()),
          //       );
          //     },
          //     icon: const Icon(
          //       Icons.info,
          //       size: 40,
          //       color: buttonColour,
          //     ),
          //   ),
          // ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Hello ${sharedPrefs.username}',
                bold: true,
                size: 25,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                radius: 35,
              )
            ],
           ),
          ),
          const SizedBox(
            height: 25,
          ),
          Image.asset(
            'assets/images/makeRecipeButton.png',
            width: 250,
          ),
          const SizedBox(
            height: 93,
          ),
          CustomButton(
              text: 'Scan',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TakePictureScreen(
                    camera: firstCamera,
                  )),
                );
              }),
          const SizedBox(
            height: 28,
          ),
          CustomButton(text: 'Storage', onPressed: () {}),
        ],
      ),
    );
  }
}
