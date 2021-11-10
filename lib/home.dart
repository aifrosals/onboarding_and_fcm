import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'keys.dart';
import 'onboarding_screen_1.dart';
import 'onboarding_screen_2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // as initializing prefs is an async task

  late SharedPreferences _prefs;

  final controller = PageController(viewportFraction: 1);

  bool _onboarding = false;

  @override
  void initState() {
    super.initState();


    // initialize firebase messaging

    initializeMessaging();

    // function for handling messages in the background

    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    // handing onscreen messages

    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print('notifications');
        print('message ${event.notification!.title} ${event.notification!
            .body}');
        showDialog(context: Keys.navigatorKey.currentContext!,
            builder: (context) =>
                AlertDialog(title: Text('${event.notification!.title}'),
                    content: Text('${event.notification!.body}'),
                ));
      }
    });

    // initialize prefs and get prefs value at the initial state
    initializePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Container(

        // onboarding pages

        child: PageView(
          controller: controller,
          children: [
            OnboardingScreen1(),
            OnboardingScreen2()
          ],
        )
      )

    );
  }
  initializePrefs() async{
    // first initialize the prefs instance
    _prefs = await SharedPreferences.getInstance();
    loadPrefs();
  }
  loadPrefs() {

    // get the value of the saved prefs if it is null set _onboarding to false

    _onboarding = _prefs.getBool('onboarding') ?? false;

    // send user to the dashboard page on initstate if onboarding is true

    if(_onboarding) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }
}


Future<void> _messageHandler(RemoteMessage message) async{
  print("Handling a background message: ${message.messageId}");
}

initializeMessaging() async {



  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // use this token to send notification to a specific user/device
 String? _token = await FirebaseMessaging.instance.getToken(vapidKey: 'token');

 print('device token $_token');

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if(event.notification != null) {
      print('message clicked inside notification');
      print('message ${event.notification!.title} ${event.notification!.body}');
    }
  });
}