import 'package:flutter/material.dart';
import 'package:rest_app/MenuScreen.dart';
import 'package:provider/provider.dart';
import 'package:rest_app/OrderScreen.dart';
import 'package:rest_app/edit_products.dart';
import 'package:rest_app/form-edit.dart';
import 'package:rest_app/models/cart.dart';
import 'package:rest_app/models/orders.dart';
import './models/items.dart';

void main () {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {


  // This widget is the root of your application.




  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

    ChangeNotifierProvider<Items>(
    create: (ctx)=>Items(),
    ),

    ChangeNotifierProvider<Cart>(
    create: (ctx)=>Cart() ,
    ),

        ChangeNotifierProvider<Orders>(
          create: (ctx)=>Orders() ,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MenuScreen(),
        routes: {
             OrderScreen.routeName: (ctx) => OrderScreen(),
             FormEdit.routeName: (ctx) => FormEdit(),
             EditProduct.routeName: (ctx ) => EditProduct(),
          MenuScreen.routeName: (ctx) => MenuScreen(),
        },
      ),
    );
  }
}
