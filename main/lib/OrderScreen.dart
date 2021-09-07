import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_app/DrawerPage.dart';
import 'package:rest_app/models/orders.dart';
import 'package:rest_app/order_dart.dart';



class OrderScreen extends StatelessWidget {

  static const routeName="/orders";
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        backgroundColor: Colors.black26,
      ),
      drawer: DrawerPage(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderProduct(orderData.orders[i])

      ),
    );
  }
}
