import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rest_app/OrderScreen.dart';
import 'package:rest_app/cart_products.dart';
import 'package:rest_app/models/orders.dart';
import './models/cart.dart';
import 'MealsCard.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<Cart>(context);
    final cartItems=carts.cartProducts.values.toList();
    final productId=carts.cartProducts.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.black45,
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
                itemCount: carts.cartProducts.values.toList().length,
                itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
                    value: carts.cartProducts.values.toList()[i],
                    child: CartProducts(productId[i])),
              ),
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              width: 450,
              child: Card(
                color: Colors.white38,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
                ),
                elevation: 5.0,

                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context,listen: false).addOrder(cartItems, carts.amount);
                      Navigator.pushNamed(context, OrderScreen.routeName);
                      carts.removeAll();
                    },
                    child: Text(
                      "ORDER NOW ",
                      style:TextStyle(
                         fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black26)),
                  ),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
