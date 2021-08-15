import 'package:flutter/material.dart';
import 'package:get_coffee_app/models/coffee.dart';
import 'package:provider/provider.dart';
import 'coffee_tile.dart';

class CoffeeList extends StatefulWidget {
  //const CoffeeList({ Key? key }) : super(key: key);

  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  
  @override
  Widget build(BuildContext context) {
    final coffees = Provider.of<List<Coffee>>(context) ?? [];
    // print(coffees.docs);

    for(var coffee in coffees)
    {
      print("${coffee.name}, ${coffee.sugars}, ${coffee.strength}");
    }

    return ListView.builder(
      itemCount: coffees.length,
      itemBuilder: (context, index) 
      {
        return CoffeeTile(coffee: coffees[index]);
      },
      
    );
  }
}