import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child:  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(child: Text('Onboarding Screen 2')),
        TextButton(onPressed: () async{
        savePrefs(context);
        }, child: Text('Next'))
      ],
    ));
  }

  savePrefs(BuildContext context) async{

    // initialize SharedPreference instance and set onboarding to true
    // that means the user has visited the onboarding for the first time

   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setBool('onboarding', true);

   // as user presses next send them to the dashboard page

   Navigator.pushReplacement(
       context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
}
