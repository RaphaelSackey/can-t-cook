import 'package:cantcook/pages/instruct_page.dart';
import 'package:cantcook/pages/signup_page.dart';
import 'package:cantcook/utils/sharedPrefs.dart';
import 'package:cantcook/widgets/background.dart';
import 'package:cantcook/widgets/customButton.dart';
import 'package:cantcook/widgets/customText.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  //const LandingPage({super.key, Key? key});

  @override
  Widget build(BuildContext context) {
    return Background(
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/landing_icon.png',
              width: 250,
            ),
          ),
          const CustomText(
              text: 'Can\'t Cook', fontFamily: 'Poller One', size: 35),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Center(
              child: CustomText(
                  text:
                      'Tap the Get Started button to begin scanning ingredients and discovering new recipes.',
                  center: true),
            ),
          ),
          const SizedBox(height: 40),
          CustomButton(
              text: 'Get Started',
              onPressed: () {
                if(!sharedPrefs.isRegistered){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InstructPage()),
                  );
                }

              }),
        ],
      ),
    );
  }
}
