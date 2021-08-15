import 'package:flutter/material.dart';
import 'package:get_coffee_app/screens/authenticate/register.dart';
import 'package:get_coffee_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  //const Authenticate({ Key? key }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView()
  {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}