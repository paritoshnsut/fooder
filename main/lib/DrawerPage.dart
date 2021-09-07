import 'package:flutter/material.dart';
import 'package:rest_app/FavScreen.dart';
import 'package:rest_app/MenuScreen.dart';
import 'package:rest_app/edit_products.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
         child: Column(
           children:<Widget> [

                 DrawerHeader(
                   decoration: BoxDecoration(
                      color: Colors.black26,
                   ),
                   child: Center(
                     child: Text("Company Name"),

                   ),
                 ),
              SizedBox(
                  height: 10,
              ),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: ListTile(
                 leading: Icon( Icons.favorite,color: Colors.red,),
                 title: Text("Favourites",
                 style:TextStyle(
                    fontSize: 15,
                   fontWeight: FontWeight.bold,
                 ),),
                 focusColor: Colors.black26,
                 hoverColor: Colors.black26,
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => FavScreen()),
                   );

                 },
               ),
             ),



             Padding(
               padding: const EdgeInsets.all(8.0),
               child: ListTile(
                 leading: Icon( Icons.edit,
                   color: Colors.black,),
                 title: Text("Edit Products",
                   style:TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.bold,
                   ),),
                 focusColor: Colors.black26,
                 hoverColor: Colors.black26,
                 onTap: (){
                   Navigator.pushNamed(
                     context, EditProduct.routeName);

                 },
               ),
             ),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: ListTile(
                 leading: Icon( Icons.restaurant_menu,
                   color: Colors.black,),
                 title: Text("Main Menu",
                   style:TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.bold,
                   ),),
                 focusColor: Colors.black26,
                 hoverColor: Colors.black26,
                 onTap: (){
                   Navigator.pushNamed(
                       context, MenuScreen.routeName);

                 },
               ),
             ),
            ],
         ),

          );
  }
}
