import 'package:flutter/cupertino.dart';
import 'package:rest_app/models/cart.dart';

class OrderItem{
  String id;
  double amount;
  List<CartItems> items;
  final DateTime dateTime;


  OrderItem(this.id,this.amount,this.items,this.dateTime);
}



class Orders with ChangeNotifier{
     List<OrderItem> _orders=[];

    List<OrderItem> get orders{
       return[..._orders];
    }

     void addOrder(List<CartItems> carts,total ){
        _orders.add(OrderItem(DateTime.now().toString(),total,carts,DateTime.now()));
        notifyListeners();
     }
}