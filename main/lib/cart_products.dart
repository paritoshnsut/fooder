import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/cart.dart';



class CartProducts extends StatelessWidget {
  final String id;
     CartProducts(this.id);
  @override

  Widget build(BuildContext context) {


    final cart=Provider.of<CartItems>(context);
    return Dismissible(
      key: ValueKey(cart.id),
      background: Container(
         child: Icon(
           Icons.delete_sweep,
           size: 50,
         ),
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
         Provider.of<Cart>(context,listen: false).removeItem(id);
      },
      child: Container(

        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.black45,
        ),
        padding: EdgeInsets.all(8.0),

        width: 420,
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(cart.imgurl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),

            Text(
              cart.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [



                RawMaterialButton(
                  onPressed: (){
                     cart.incQuantity();
                  },
                  constraints: BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 40.0,
                  ),
                  elevation: 5.0,
                  focusElevation: 10.0,
                  focusColor: Color(0xFF0A0F33),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),

                Text(
                  cart.quantity.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),

                RawMaterialButton(
                  onPressed: (){
                     cart.descQuantity();
                  },
                  constraints: BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 40.0,
                  ),
                  elevation: 5.0,
                  focusElevation: 10.0,
                  focusColor: Color(0xFF0A0F33),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),


                Text(
                  cart.calcPrice().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
