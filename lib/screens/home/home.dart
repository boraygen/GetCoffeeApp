import 'package:flutter/material.dart';
import 'package:get_coffee_app/models/coffee.dart';
import 'package:get_coffee_app/screens/home/coffee_list.dart';
import 'package:get_coffee_app/screens/home/settings_form.dart';
import 'package:get_coffee_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:get_coffee_app/services/database.dart';


class Home extends StatelessWidget {
  //const Home({ Key? key }) : super(key: key);

  final AuthService _auth = AuthService();
  

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() 
    {
      showModalBottomSheet(context: context, builder: (context)
      {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffees,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text("Get Coffee"),
          backgroundColor: Colors.brown[400],
          elevation: 3,
          actions: [
            TextButton(
              onPressed: () async
              {
                showAlertDialog(context);
              }, 
              child: const Text("Logout", style: TextStyle(color: Colors.white),
              ),
              //clipBehavior: Clip,
            ),
            TextButton.icon( 
              icon: const Icon(Icons.settings, color: Colors.white, size: 20), 
              label: const Text("Settings", style: TextStyle(color: Colors.white),),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          child: CoffeeList(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/coffee_bg.png"),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget logoutButton = TextButton(
    child: Text("Logout", style: TextStyle(color: Colors.brown[700]),),
    onPressed:  () async
    {
      await _auth.signOut();
      Navigator.pop(context);
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel", style: TextStyle(color: Colors.brown[700]),),
    onPressed:  () 
    {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning", style: TextStyle(color: Colors.brown[900]),),
    content: const Text("Are you sure you want to logout?"),
    actions: [
      logoutButton,
      cancelButton,  
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  
}