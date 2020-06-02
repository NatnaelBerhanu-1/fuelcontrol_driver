import 'package:flutter/foundation.dart';
import 'package:fuelcontrol/models/models.dart';
import 'package:fuelcontrol/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrState {Idle, Busy, Success, Error}

class PaymentRecordViewModel extends ChangeNotifier{

  UserRepository _userRepository;
  Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  PrState prState;
  List<PaymentRecord> paymentRecords;

  PaymentRecordViewModel(){
    if(_userRepository == null){
      _userRepository = UserRepository(preferences: _sharedPreferences);
    }
    getPaymentRecord('all', false);
  }

  setState(PrState state){
    prState = state;
    notifyListeners();
  }

  Future<List<PaymentRecord>> getPaymentRecord(String filter, bool refresh) async{
    setState(PrState.Busy);
    var response = await _userRepository.getPaymentRecord(filter, refresh);
    if(response == null){
      setState(PrState.Error);
      return null;
    }
    paymentRecords = response;
    setState(PrState.Success);
  }

}