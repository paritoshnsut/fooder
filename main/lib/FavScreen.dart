import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_app/MealsCard.dart';
import 'package:rest_app/models/items.dart';



class FavScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

final favs= Provider.of<Items>(context,listen: false).Fav;
    return Scaffold(

      appBar: AppBar(
         title: Text("Favourite Meals"),
        backgroundColor: Colors.black12,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
            itemCount: favs.length,
             itemBuilder:(ctx,i) => ChangeNotifierProvider.value(
                 value: favs[i],
                 child: MealsCard())),
      )
    );
  }
}
