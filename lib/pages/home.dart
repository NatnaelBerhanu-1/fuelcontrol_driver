import 'package:flutter/material.dart';
import 'package:fuelcontrol/widgets/info_card.dart';
import 'package:fuelcontrol/viewModels/screens/home_view_model.dart';
import 'package:fuelcontrol/widgets/retry.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<HomeViewModel>(
      builder:(context, homeViewModel, child) => homeViewModel.homeState == HomePageState.Success? SingleChildScrollView(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10.0))),
                child: Center(
                  child: QrImage(
                    data: homeViewModel.loggedInUser.email,
                    version: QrVersions.auto,
                    size: 150.0,
                  ),
                )
              ),
              SizedBox(
                height: 20.0,
              ),
              InfoCard(
                title: 'Balance',
                desc: '${homeViewModel.loggedInUser.balance}',
                icon: Icon(
                  Icons.monetization_on,
                  size: 45.0,
                  color: Colors.black,
                ),
              ),
              InfoCard(
                title: 'Monthly spent',
                desc: '${homeViewModel.loggedInUser.monthlySpent} br',
                icon: Icon(
                  Icons.timelapse,
                  size: 45.0,
                  color: Colors.black,
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom:15.0, left: 5.0, right: 5.0),
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                        begin:Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Profile',
                            style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Name: ${homeViewModel.loggedInUser.name}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Email: ${homeViewModel.loggedInUser.email}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Status: ${homeViewModel.loggedInUser.status}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: (){
                              Scaffold.of(context).showBottomSheet((context) => _buildBottomSheet(context));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(
                                'change password',
                                style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.greenAccent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ): homeViewModel.homeState == HomePageState.Error?Retry(callback: (){homeViewModel.getUser(false);}):Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      )
    );
  }

  Widget _buildBottomSheet(BuildContext context){
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
            color: Colors.black12,
            width: 2.0,
          )
        ),
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Text(
                  'Change Password',
                  style: Theme.of(context).textTheme.subtitle.copyWith(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                ),
              ),
              Consumer<HomeViewModel>(
                builder:(context, homeViewModel, child) => homeViewModel.changePasswordState == HomePageState.Error? Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: Text(
                    '${homeViewModel.error}',
                    style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).errorColor),
                  ),
                ): homeViewModel.changePasswordState == HomePageState.Success ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: Text(
                    'password changed successfully',
                    style: Theme.of(context).textTheme.body1.copyWith(color: Colors.green, fontSize: 14.0),
                  ),
                )
                :Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<HomeViewModel>(
                  builder:(context, homeViewModel, child) => TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'new password',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.0
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).buttonColor,
                      )
                    ),
                    onChanged: (val){
                      homeViewModel.newPassword = val;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Consumer<HomeViewModel>(
                    builder:(context, homeViewModel, child) => FlatButton(
                      onPressed: (){
                          homeViewModel.changePassword();
                      },
                      color: Theme.of(context).primaryColor,
                      child: Consumer<HomeViewModel>(
                        builder:(context, homeViewModel, child)=> homeViewModel.changePasswordState == HomePageState.Busy?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ): Text(
                          'change password',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
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
