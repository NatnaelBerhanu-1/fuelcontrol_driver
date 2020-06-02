class Invoice {
  int id;
  double litre;
  double price;
  DateTime time;

  Invoice({this.id, this.litre, this.price, this.time});
}

class Notif {
  int id;
  String title;
  String desc;
  DateTime time;
  bool isnew;

  Notif({this.id, this.title, this.desc, this.time, this.isnew});
}

class Notification {
  int invoice;
  int userId;
  double costPerItem;
  double amount;
  double total;
  String date;

  Notification({this.invoice, this.userId, this.costPerItem, this.amount,
      this.total, this.date});

  factory Notification.fromJson(Map<String, dynamic> json){
    return Notification(
      invoice: int.parse(json['invoice'].toString()),
      userId: int.parse(json['user_id'].toString()),
      costPerItem: double.parse(json['costperitem'].toString()),
      amount: double.parse(json['amount'].toString()),
      total: double.parse(json['total'].toString()),
      date: json['created_at']
    );
  }


}

class User {
  int id;
  String name;
  String email;
  String password;
  double balance;
  String status;
  String monthlySpent;
  Role role;
  Department department;

  User({this.id, this.name, this.email, this.password, this.balance, this.status,
      this.role, this.department, this.monthlySpent});

  factory User.fromJson(Map<String, dynamic> json){
    var roles = json['role'];
    var role = Role.fromJson(roles[0]);
    var dept = Department.fromJson(json['department']);

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      balance: double.parse(json['balance'].toString()),
      status: json['status'],
      role: role,
      department: dept,
      monthlySpent: json['monthly'].toString()
    );
  }
}

class Department {
  int id;
  String name;
  String description;

  Department({this.id, this.name, this.description});

  factory Department.fromJson(Map<String, dynamic> json){
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }


}

class Role {
  int id;
  String name;
  String description;

  Role({this.id, this.name, this.description});

  factory Role.fromJson(Map<String, dynamic> json){
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

}

class PaymentRecord {
   double price;
   String type;
   String date;

   PaymentRecord({this.price, this.date, this.type});

   factory PaymentRecord.fromJson(Map<String, dynamic> json){
     return PaymentRecord(
       price: double.parse(json['price'].toString()),
       date: json['created_at'],
       type: json['type'],
     );
   }
}