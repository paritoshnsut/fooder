import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Item with ChangeNotifier {
   final String catId;
   final String id;
   final String imgUrl;
   final String name;
   final double price;
   final bool isveg;
   bool isfav;

  Item({ this.catId, this.id, this.imgUrl, this.name, this.price, this.isveg,this.isfav=false
  });

  void toggleFavourite(){
     isfav=!isfav;
     notifyListeners();
  }
}

class Items with ChangeNotifier {
  List<Item> _items = [
    // Item(
    //    catId: "starter",
    //    id: "str1",
    //    imgUrl: "https://www.verywellfit.com/thmb/i7MkyuL0Bs5Ksl4uem8rVAo_PXg=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/chicken-noodle-soup-g18-56a8c0ce5f9b58b7d0f4d15f.jpg",
    //    name: "Soup",
    //    price:   200.0,
    //    isveg: false),
    // Item(
    //    catId:  "starter",
    //    id: "str2",
    //    imgUrl:  "https://www.verywellfit.com/thmb/i7MkyuL0Bs5Ksl4uem8rVAo_PXg=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/chicken-noodle-soup-g18-56a8c0ce5f9b58b7d0f4d15f.jpg",
    //    name:  "Soup",
    //    price:  200.0,
    //    isveg:  false),
    // Item(
    //    catId:  "starter",
    //     id: "str3",
    //     imgUrl: "https://www.verywellfit.com/thmb/i7MkyuL0Bs5Ksl4uem8rVAo_PXg=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/chicken-noodle-soup-g18-56a8c0ce5f9b58b7d0f4d15f.jpg",
    //     name: "Soup",
    //     price: 200.0,
    //     isveg: false),
    //
    // Item(
    //    catId: "NV",
    //    id: "nv1",
    //    imgUrl:  "https://upload.wikimedia.org/wikipedia/commons/3/35/Biryani_Home.jpg",
    //    name:  "Chicken Biryani",
    //    price:  400.0,
    //     isveg: false),
    // Item(
    //   catId:  "NV",
    //     id: "nv2",
    //     imgUrl:"https://upload.wikimedia.org/wikipedia/commons/3/35/Biryani_Home.jpg",
    //    name: "Chicken Biryani",
    //    price:  400.0,
    //     isveg: false),
    // Item(
    //     catId: "NV",
    //     id: "nv3",
    //     imgUrl:"https://upload.wikimedia.org/wikipedia/commons/3/35/Biryani_Home.jpg",
    //     name:"Chicken Biryani",
    //     price: 400.0,
    //     isveg: false),
    // Item(
    //     catId: "NV",
    //     id: "nv4",
    //     imgUrl:"https://upload.wikimedia.org/wikipedia/commons/3/35/Biryani_Home.jpg",
    //     name: "Chicken Biryani",
    //     price: 400.0,
    //     isveg: false),
    //
    //  Item(
    //      catId: "veg",
    //      id:"v1",
    //      imgUrl: "https://images.app.goo.gl/5ce4AHfeThEZczBd6",
    //      name: "Veg Pulao",
    //      price: 300.0 ,
    //      isveg: true ),
    //  Item(
    //      catId:"veg",
    //      id: "v2",
    //      imgUrl: "https://images.app.goo.gl/5ce4AHfeThEZczBd6",
    //      name: "Veg Pulao",
    //      price: 300.0 ,
    //       isveg:  true ),
    //  Item(
    //      catId: "veg",
    //     id: "v3",
    //      imgUrl: "https://images.app.goo.gl/5ce4AHfeThEZczBd6",
    //      name: "Veg Pulao",
    //      price:300.0 ,
    //      isveg: true ),

  ];


   List<Item> get items{
        return [..._items];
   }

  Future<void> getData() async{
     const url="https://rest-app-3a388-default-rtdb.asia-southeast1.firebasedatabase.app/Items.json";
     try {
       var response = await http.get(Uri.parse(url));

       var extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(extractedData);
       List<Item> loadedItems = [];
       extractedData.forEach((key, value) {
        final newItem=   Item(
             id: key,
             catId:value['catId'],
             name: value['name'],
             imgUrl: value['imgUrl'],
             price: value['price'],
           );
        loadedItems.add(newItem);
       });
       _items=loadedItems;
     }
      catch(error) {

        throw error;
      }

   }
  // ignore: non_constant_identifier_names
    List<Item> get Starters{
      return [..._items.where((item) => item.catId=="starter").toList()];
    }
  // ignore: non_constant_identifier_names
  List<Item> get Nonveg{
     return [..._items.where((item) => item.catId=="NV").toList()];
  }

  // ignore: non_constant_identifier_names
  List<Item> get Veg{
     return [..._items.where((item) => item.catId=="veg").toList()];
  }

  // ignore: non_constant_identifier_names
  List<Item> get Fav{
    return [..._items.where((item) => item.isfav==true).toList()];
  }

  Future<void> addItem (Item item ) async{


     const url="https://rest-app-3a388-default-rtdb.asia-southeast1.firebasedatabase.app/Items.json";
   try {
     var response = await http.post(Uri.parse(url), body: json.encode({
       'catId': item.catId,
       'name': item.name,
       'imgUrl': item.imgUrl,
       'isfav': item.isfav,
       'price': item.price,
       'isveg': item.isveg,
     }));


     _items.add(
       Item(
         id: json.decode(response.body)['name'],
         catId: item.catId,
         name: item.name,
         imgUrl: item.imgUrl,
         isfav: item.isfav,
         price: item.price,
         isveg: item.isveg,
       ),
     );


     notifyListeners();
   }
      catch(error){
         throw error;
      }
  }


   Future<void> updateItem(String id,Item item) async {


     final url= "https://rest-app-3a388-default-rtdb.asia-southeast1.firebasedatabase.app/Iems/$id.jsn";
     int num= _items.indexWhere((element) => element.id == id );


     await http.patch(Uri.parse(url), body: json.encode({

       'name': item.name,
       'imgUrl': item.imgUrl,
       'price': item.price,
     }));

     _items[num] = item;
      notifyListeners();






   }



    Item findById(String id){
     return _items.firstWhere((element) => element.id == id);
    }

  Future<void> removeItem(String id) async{
      int num= _items.indexWhere((element) => element.id == id );
     var data =_items[num];

     var url="https://rest-app-3a388-default-rtdb.asia-southeast1.firebasedatabase.app/It/$id.json";
     http.delete(Uri.parse(url)).then((_){
        _items.removeAt(num);
        notifyListeners();

    }).catchError((error){
       _items.insert(num,data);
       notifyListeners();
       throw error;
      });

    data=null;
  }

}