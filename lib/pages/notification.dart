import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelcontrol/viewModels/screens/notification_view_model.dart';
import 'package:fuelcontrol/widgets/invoice_item.dart';
import 'package:fuelcontrol/widgets/retry.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<NotificationViewModel>(
      builder:(context, viewModel, child) => viewModel.pageState == ViewState.Success ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
              viewModel.notifications.map((notification){
                return InvoiceItem(notification: notification,);
              }).toList()
          ),
        ),
      ): viewModel.pageState == ViewState.Busy? Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ): viewModel.pageState == ViewState.Error? Container(child: Retry(callback: viewModel.getNotifications)):Container(),
    );
  }
}