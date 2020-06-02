import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelcontrol/models/models.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget{
  Notif notification;

  NotificationItem({@required this.notification});

  @override
  Widget build(BuildContext context) {
    return _buildNotificationItem(context);
  }

  Widget _buildNotificationItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top:8.0, left: 8.0, right:8.0),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${notification.title}',
            style: Theme.of(context).textTheme.subtitle.copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
          ),
          Text(
            '${notification.desc}',
            style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                notification.isnew?Container(
                  height: 25.0,
                  width: 75.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight.withOpacity(0.3),
                      borderRadius:BorderRadius.all(Radius.circular(13.0)),
                    ),
                    child: Center(
                      child: Text(
                        'new',
                        style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ):Container(),
                Text(
                  '${DateFormat('yyyy-mm-dd kk-mm').format(DateTime.now())}',
                  style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).accentColor, fontSize: 14.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}