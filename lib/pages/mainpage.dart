import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:fuelcontrol/pages/login.dart';
import 'package:fuelcontrol/viewModels/Screens/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'notification.dart';
import 'statistics.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  num _selectedIndex = 0;
  PageController _pageController;
  final title = ['Home', 'Statistics', 'Notification'];

  final pages = [HomePage(), StatPage(), NotificationPage()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(title[_selectedIndex]),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.remove("loggedIn");
              preferences.remove("loggedInEmail");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.power_settings_new),
          )
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: pages),
      ),
      bottomNavigationBar: BottomNavyBar(
        iconSize: 20.0,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavyBarItem(
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).buttonColor,
              icon: Icon(Icons.home),
              title: Text(
                'home',
                style: TextStyle(fontSize: 16.0),
              )),
          BottomNavyBarItem(
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).buttonColor,
              icon: Icon(Icons.show_chart),
              title: Text(
                'statistics',
                style: TextStyle(fontSize: 16.0),
              )),
          BottomNavyBarItem(
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).buttonColor,
              icon: Icon(Icons.notifications),
              title: Text(
                'notification',
                style: TextStyle(fontSize: 16.0),
              ))
        ],
      ),
    );
  }
}
