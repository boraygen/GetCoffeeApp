import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_coffee_app/screens/authenticate/authenticate.dart';
import 'package:get_coffee_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    //return Home or Authenticate
    return user != null ? Home() : Authenticate();
    // if (user != null)
    // {
    //   return Home();
    // }
    // else
    // {
    //   return Authenticate();
    // }
  }
}