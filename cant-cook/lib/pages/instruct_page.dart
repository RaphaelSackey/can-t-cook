import 'package:cantcook/pages/home_page.dart';
import 'package:cantcook/widgets/customButton.dart';
import 'package:cantcook/widgets/customText.dart';
import 'package:flutter/material.dart';

class InstructPage extends StatelessWidget {
  const InstructPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCEFE3),
      appBar: AppBar(
        title: const Text("Instructions"),
        backgroundColor: const Color(0xFFDCEFE3),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Image.asset(
                'assets/images/landing_icon.png',
                height: 200,
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ), // Add left and right padding
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                      16.0), // Add padding to the container
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Offset for the shadow
                      ),
                    ],
                    borderRadius:
                        BorderRadius.circular(4), // Adjust the radius value
                    color: const Color(0xFFDCEFE3), // Background color
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0), // Add top and bottom padding
                    child: CustomText(
                      text:
                          '1) Use your camera to take a picture of the food items. Results are best when the items are laid out. \n \n2) Confirm the picture you want to use. \n \n3) See results for meals you can cook with your items.',
                    ),
                  ),
                ),
                // Add more widgets to the column if needed
              ],
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: 'Take a picture',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
