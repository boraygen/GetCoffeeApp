import 'package:flutter/material.dart';
import 'package:get_coffee_app/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  //const CoffeeTile({ Key? key }) : super(key: key);
  final Coffee coffee;
  CoffeeTile({this.coffee});
  
  String _sugarS()
  {
    return int.parse(coffee.sugars) < 2 ? "sugar" : "sugars";
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20,6,20,0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[coffee.strength],
            backgroundImage: const AssetImage("assets/coffee_icon.png"),       
          ),
          title: Text(coffee.name),
          subtitle: Text("Takes ${coffee.sugars} ${_sugarS()}."),

        ),
      ),
      
    );
  }
}