import 'package:flutter/material.dart';
import 'package:get_coffee_app/services/auth.dart';
import 'package:get_coffee_app/shared/loading.dart';


class SignIn extends StatefulWidget {
  //const SignIn({ Key? key }) : super(key: key);

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _signEmail = "";
  String _signPw = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 3,
        title: const Text("Sign in to Get Coffee"),
          actions: [
            Tooltip(
              message: "Go to \"Register\" page.",
              child: TextButton.icon(
                onPressed: ()
                {
                  widget.toggleView();
                },
                icon: const Icon(Icons.undo, 
                color: Colors.white,
                size: 19,
                ), 
                label: const Text("Register", style: TextStyle(color: Colors.white),
                ),
                //clipBehavior: Clip,
              ),
            )
          ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextFormField(  //email section
                validator: (value) => value.isEmpty || !value.contains("@") ? "Enter a valid email" : null,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                onChanged: (value)
                {
                  setState(() 
                  {
                    _signEmail = value;
                  });
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(  //password section
                validator: (value) => value.length < 6 ? "Enter a password 6+ chars long" : null,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                obscureText: true,
                onChanged: (value)
                {
                  setState(() 
                  {
                    _signPw = value;
                  });
                },
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 150),
                child: loading ? Loading() : ElevatedButton(
                  style: TextButton.styleFrom(
                    elevation: 6,
                    backgroundColor: Colors.white,        
                  ),
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.brown[900],
                    ),
                  ),
                  onPressed: () async
                  {
                    if(_formKey.currentState.validate())
                    {
                      setState(() => loading = true);
                      
                      dynamic result = await _auth.signInWithEmailPw(_signEmail, _signPw);
                      if (result == null)
                      {
                        setState(() {
                          error = "Wrong email and/or password.";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 12,),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 20),
              )
            ],
          ),
        ),
      
      ),
    );
  }
}