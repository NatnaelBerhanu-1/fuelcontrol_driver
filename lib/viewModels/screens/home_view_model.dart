import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:fuelcontrol/models/models.dart';
import 'package:fuelcontrol/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HomePageState {Idle, Busy, Success, Error}

class HomeViewModel extends ChangeNotifier{

  String error;
  String newPassword = '';
  HomePageState homeState = HomePageState.Idle;
  HomePageState changePasswordState = HomePageState.Idle;
  User loggedInUser;
  bool load = true;
  
  UserRepository _userRepository;
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  HomeViewModel(){
    if (_userRepository == null){
      _userRepository = UserRepository(preferences: sharedPreferences);
    }
    getUser(false);
  }

  Future<User> getUser(bool refresh) async {
    print('Gettting user');
    setState(HomePageState.Busy);
    User user = await _userRepository.getUser(refresh);
    if(user == null){
      print('user is null');
      error = 'error getting user';
      setState(HomePageState.Error);
      return null;
    }
    print('user is not null');
    setState(HomePageState.Success);
    loggedInUser = user;
    if(load){
      load = false;
      await Pusher.init(
          "37057a3e52fcd650ef11",
          PusherOptions(
              cluster: "mt1"
          ),
          enableLogging: true
      );
      await Pusher.connect(onConnectionStateChange: (x) async {
        print("pusher connect: $x");
      }, onError: (x){
        print("pusher error: $x");
      });
      Channel channel = await Pusher.subscribe('paymentdone${loggedInUser.id}');
      channel.bind('payment-done', (x){
        var balance = json.decode(x.data)['balance'];
        loggedInUser.balance = double.parse(balance.toString());
        notifyListeners();
      });
    }
    return user;
  }

  Future<bool> changePassword() async{
    if(newPassword.length < 4){
      error = 'minimum length is 4';
      setChangePasswordState(HomePageState.Error);
      return false;
    }
    error = '';
    notifyListeners();
    setChangePasswordState(HomePageState.Busy);
    bool response = await _userRepository.changePassword(newPassword);
    if(response == true){
      newPassword = '';
      notifyListeners();
      setChangePasswordState(HomePageState.Success);
      return true;
    }
    setChangePasswordState(HomePageState.Error);
    return null;
  }

  setState(HomePageState state){
    homeState = state;
    notifyListeners();
  }

  setChangePasswordState(HomePageState state){
    changePasswordState = state;
    notifyListeners();
  }


}