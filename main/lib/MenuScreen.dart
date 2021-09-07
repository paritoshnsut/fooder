import 'package:flutter/material.dart';
import 'package:hover_effect/hover_effect.dart';
import 'package:rest_app/CartScreen.dart';
import 'MealsCard.dart';
import 'package:provider/provider.dart';
import './models/items.dart';
import 'DrawerPage.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = 'main-menu';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  bool _isloading = false;



  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      _isloading = true;
    });
    Provider.of<Items>(context).getData().then((_) {
      setState(() {
        _isloading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Veg = Provider.of<Items>(context).Veg;
    // ignore: non_constant_identifier_names
    final Nonveg = Provider.of<Items>(context).Nonveg;
    final starters = Provider.of<Items>(context).Starters;

    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(
          "Rest App",
          softWrap: true,
          overflow: TextOverflow.fade,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.white70),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: _isloading
          ? Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 10),
                  child: Text(
                    "Starters",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black45,
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: starters.length,
                          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                            value: starters[i],
                            child: MealsCard(),
                          ),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 10.0),
                  child: Text(
                    "Veg Meal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black45,
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Veg.length,
                          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                            value: Veg[i],
                            child: MealsCard(),
                          ),


                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 10.0),
                  child: Text(
                    "Non-Veg Meal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black45,
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Nonveg.length,
                          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                            value: Nonveg[i],
                            child: MealsCard(),
                          ),

                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
