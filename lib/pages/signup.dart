import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuelcontrol/main.dart';
import 'package:fuelcontrol/pages/home.dart';
import 'package:fuelcontrol/pages/login.dart';
import 'package:fuelcontrol/pages/mainpage.dart';

class SignUp extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final gradientColor = [
    Color(0xFFF22613),
    Color(0xFFF34C3D),
  ];

  String email = '', password = '', fullName = '', cPassword = '', cPasswordError, fullNameError, emailError, passwordError;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return _buildLoginPage(context);
  }

  Widget _buildLoginPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Stack(children: <Widget>[
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150))),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(left: 80, bottom: 40, right: 20),
                    child: Text(
                      'Welcome Please Signup to continue',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 42.0, bottom: 8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              fullNameError = null;
                            });
                          }
                          setState(() {
                            fullName = value;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorText: fullNameError,
                          hintText: 'full name',
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintStyle:
                          TextStyle(color: Theme.of(context).buttonColor),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              emailError = null;
                            });
                          }
                          setState(() {
                            email = value;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorText: emailError,
                          hintText: 'email',
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintStyle:
                          TextStyle(color: Theme.of(context).buttonColor),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                        obscureText: true,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              passwordError = null;
                            });
                          }
                          setState(() {
                            password = value;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorText: passwordError,
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintText: 'password',
                          hintStyle:
                          TextStyle(color: Theme.of(context).buttonColor),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              cPasswordError = null;
                            });
                          }
                          setState(() {
                            cPassword = value;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorText: cPasswordError,
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintText: 'confirm password',
                          hintStyle:
                          TextStyle(color: Theme.of(context).buttonColor),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(top: 10.0),
                height: 52.0,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (fullName == null || fullName == ''){
                      setState(() {
                        fullNameError = 'field required';
                      });
                      return;
                    }
                    else if(!(fullName.contains(' '))){
                      setState(() {
                        fullNameError = 'invalid input';
                      });
                      return;
                    }
                    if (email == null || email == '') {
                      setState(() {
                        emailError = 'field required';
                      });
                      return;
                    } else if (!(email.contains("@") &&
                        email.contains(".com"))) {
                      setState(() {
                        emailError = 'invalid email';
                      });
                      return;
                    }
                    if (password == null || password == '') {
                      setState(() {
                        passwordError = 'field required';
                      });
                      return;
                    } else if (password.length < 4) {
                      setState(() {
                        passwordError = 'min length for password is 4';
                      });
                      return;
                    }
                    if(cPassword != password){
                      setState(() {
                        cPasswordError = 'password doesn\'t match';
                      });
                      return;
                    }

                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => MainPage()), (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'signup',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      'signin',
                      style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
