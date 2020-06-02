import 'package:flutter/foundation.dart';
import 'package:fuelcontrol/models/models.dart';
import 'package:fuelcontrol/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ViewState {Idle, Busy, Success, Error}

class NotificationViewModel extends ChangeNotifier{
  ViewState pageState = ViewState.Idle;
  UserRepository _userRepository;
  Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  List<Notification> notifications;

  NotificationViewModel(){
    if(_userRepository == null){
      _userRepository = UserRepository(preferences: _sharedPreferences);
    }
    getNotifications();
  }

  setState(ViewState state){
    pageState = state;
    notifyListeners();
  }

  Future<bool> getNotifications() async{
    setState(ViewState.Busy);
    var response = await _userRepository.getNotifications();
    if(response == null){
      setState(ViewState.Error);
      return false;
    }
    notifications = response;
    setState(ViewState.Success);
    return true;
  }

}