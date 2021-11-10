import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(child: Text('Dashboard')),
          TextButton(onPressed: deletePrefs, child: Text('Delete prefs'))
        ],
      )),
    );
  }
  deletePrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
