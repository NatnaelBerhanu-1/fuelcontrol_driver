import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelcontrol/models/models.dart' as models;
import 'package:intl/intl.dart';

class InvoiceItem extends StatelessWidget{
  models.Notification notification;
  InvoiceItem({@required this.notification});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildInvoiceItem(context);
  }

  Widget _buildInvoiceItem(BuildContext context) {
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
            'Invoice',
            style: Theme.of(context).textTheme.subtitle.copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Transport\nBritish Embassy',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor, fontSize: 16.0),
                ),
                Text(
                  '#${notification.invoice}',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).primaryColor, fontSize: 20.0),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Cost per 1 liter',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor, fontSize: 16.0),
                ),
                Text(
                  '${notification.costPerItem}',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor, fontSize: 18.0),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Amount In litre',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor, fontSize: 16.0),
                ),
                Text(
                  'L ${notification.amount}',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor, fontSize: 18.0),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).buttonColor,
            indent: 1.0,
            endIndent: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor, fontSize: 16.0),
                ),
                Text(
                  '${notification.total}',
                  style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).buttonColor, fontSize: 18.0),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${DateFormat('${notification.date}').format(DateTime.now())}',
                  style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).hintColor, fontSize: 14.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}