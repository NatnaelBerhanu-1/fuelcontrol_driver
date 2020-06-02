import 'dart:convert';
import 'package:fuelcontrol/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = 'https://zowitech.com/api/v1/';

class UserRepository {
  final Future<SharedPreferences> preferences;
  User loggedInUser;
  List<PaymentRecord> paymentRecords;

  UserRepository({this.preferences});

  Future<bool> login(User user) async {
    print('login ur');
    final SharedPreferences prefs = await preferences;
    try {
      print('login try');
      var response = await http.post(baseUrl + 'login', body: {
        'email': user.email,
        'password': user.password,
        'filter': 'driver'
      }).timeout(Duration(seconds: 10));

      print(response.body);

      if (response.statusCode == 200) {
        User usr = User.fromJson(json.decode(response.body)['data']);
        print(usr.role.name);
        if (usr.role.name == 'driver') {
          prefs.setString('loggedIn', 'true');
          prefs.setString('loggedInEmail', usr.email);
          loggedInUser = usr;
          return true;
        }
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      print("error here");
      return false;
    }
  }

  Future<User> getUser(bool refresh) async {
    if (refresh || loggedInUser == null) {
      final SharedPreferences prefs = await preferences;
      try {
        String email = prefs.get("loggedInEmail");
        print('email $email');
        var response = await http.post('${baseUrl}users/byemail?role=driver', body: {'email':email});
        print(response.body);
        if (response.statusCode == 200) {
          User usr = User.fromJson(json.decode(response.body)['data']);
          return usr;
        }
        return null;
      } catch (e) {
        print(e);
        return null;
      }
    }
    return loggedInUser;
  }

  Future<List<PaymentRecord>> getPaymentRecord(String filter,
      [bool refresh = false]) async {
    print(refresh);
    if (paymentRecords == null || refresh == true) {
      try {
        User user = await getUser(false);
        var response = await http.get(
            '${baseUrl}paymentrecords/filter/${user.id}?filter=$filter&user=driver');
        print(response.body);
        if (response.statusCode == 200) {
          List<dynamic> prJson = json.decode(response.body)['data'];
          print(prJson);
          paymentRecords = List();
          prJson.forEach((pr) {
            if (filter == 'all') {
              PaymentRecord paymentRecord = PaymentRecord(
                price: double.parse(pr['price'].toString()),
                type: pr['type'],
                date: pr['created_at'],
              );
              paymentRecords.add(paymentRecord);
            } else if (filter == 'monthly') {
              PaymentRecord paymentRecord = PaymentRecord(
                price: double.parse(pr['price'].toString()),
                type: pr['type'],
                date: pr['month'].toString() + '-' + pr['year'].toString(),
              );
              paymentRecords.add(paymentRecord);
            } else if (filter == 'yearly') {
              PaymentRecord paymentRecord = PaymentRecord(
                price: double.parse(pr['price'].toString()),
                type: pr['type'],
                date: pr['year'].toString(),
              );
              paymentRecords.add(paymentRecord);
            }
          });
          print(paymentRecords);
          return paymentRecords;
        }
        return null;
      } catch (e) {
        print(e);
        return null;
      }
    }
    return paymentRecords;
  }

  Future<bool> changePassword(String password) async {
    try {
      User user = await getUser(false);
      var data = {
        'email': user.email,
        'name': user.name,
        'department_id': user.department.id.toString(),
        'status': user.status,
        'balance': user.balance.toString(),
        'password': password,
        '_method': 'PUT'
      };
      var response = await http.post('${baseUrl}users/${user.id}', body: data);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Notification>> getNotifications() async {
    List<Notification> notifications = List();
    try {
      User user = await getUser(false);
      var response =
          await http.get('${baseUrl}notifications?user_id=${user.id}');
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> rawNotif = json.decode(response.body)['data'];
        rawNotif.forEach((notif) {
          notifications.add(Notification.fromJson(notif));
        });
        print(notifications);
        return notifications;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
