import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class CartItems with ChangeNotifier{

  @required String id;
  @required double price;
  int quantity;
  @required String name;
  @required String imgurl;

  CartItems(this.id,this.price,this.imgurl,this.name,{this.quantity=1});


  void incQuantity(                                 ){
     quantity++;
     notifyListeners();
  }


  void descQuantity(){
    if(quantity>1){
      quantity--;
    }
     notifyListeners();

}


  double calcPrice(){
    double total=0.0;
    total+= quantity*price;

    return total;
  }

}


class Cart with ChangeNotifier{

   Map<String,CartItems> _cartItems={};


   Map<String,CartItems> get cartProducts{
     return{..._cartItems};
   }


   double get amount{
     double total=0.0;

      _cartItems.forEach((key, cartItem) {

         total+=cartItem.price*cartItem.quantity;
      });
      return total;
   }


   void addCart(String key, double price, String imgurl,String name) {
 if(  _cartItems.containsKey(key))
   {
    // _cartItems.update(key, (value) => CartItems(value.id,value.price, value.imgurl, value.name,));
     _cartItems[key].quantity+=1;
   }



else {
_cartItems.putIfAbsent(
key, () => CartItems(DateTime.now().toString(), price, imgurl, name));

}

notifyListeners();
}



void removeItem(String cartId){
  _cartItems.remove(cartId);
  notifyListeners();
}


void removeAll(){
      _cartItems.clear();
      notifyListeners();
}
}