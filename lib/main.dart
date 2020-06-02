import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:fuelcontrol/pages/home.dart';
import 'package:fuelcontrol/pages/login.dart';
import 'package:fuelcontrol/pages/mainpage.dart';
import 'package:fuelcontrol/pages/notification.dart';
import 'package:fuelcontrol/pages/signup.dart';
import 'package:fuelcontrol/pages/statistics.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if(sharedPreferences.get('loggedIn') == 'true'){
    runApp(MyApp(MainPage()));
    return;
  }
  runApp(MyApp(LoginPage()));
}

class MyApp extends StatelessWidget {
  Widget to;
  MyApp(this.to);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fuel Control',
      theme: ThemeData(
        primaryColor: Color(0xFFF22613),
        primaryColorLight: Color(0xFFF34C3D),
        backgroundColor: Color(0xFF2B2B2B),
        buttonColor: Color(0xFF707070),
        accentColor: Color(0xFFF29513),
        hintColor: Color(0xFF006FFF),
        textTheme: TextTheme(
          title: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          subtitle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          body1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white),
        )
      ),
      home: to,
    );
  }
}

