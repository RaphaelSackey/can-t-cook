import 'package:cantcook/pages/instruct_page.dart';
import 'package:cantcook/utils/sharedPrefs.dart';
import 'package:cantcook/widgets/background.dart';
import 'package:cantcook/widgets/customButton.dart';
import 'package:cantcook/widgets/customText.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      widget: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 178.0),
              child: CustomText(
                text: 'Welcome to your healthy future',
                center: true,
                bold: true,
                size: 25,
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(text: 'Let\'s help you find your perfect recipe.'),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  setState(() {
                    Form.of(primaryFocus!.context!).save();
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const UnderlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.person,
                            size: 40,
                            color: Color(0xFF00BFA6),
                          ),
                          labelText: 'Username',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                        text: 'Continue',
                        onPressed: () {
                          if(_usernameController.text.isNotEmpty){
                            sharedPrefs.username = _usernameController.text;
                          }
                          sharedPrefs.isRegistered = true;
                          var snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            width: MediaQuery.of(context).size. width * 0.7,
                            duration: const Duration(seconds: 1),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            content: CustomText(text:'Welcome ${sharedPrefs.username}', size: 18, color: Colors.white, space: 1),
                            backgroundColor:Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InstructPage()),
                          );
                        }),
                    // child: const CustomText(text: 'Continue'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
