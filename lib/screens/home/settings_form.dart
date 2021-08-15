import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_coffee_app/models/user.dart';
import 'package:get_coffee_app/services/database.dart';
import 'package:get_coffee_app/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  //const SettingsForm({ Key? key }) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String _sugarS(int sugar)
  {
    return  sugar < 2 ? "sugar" : "sugars";
  }

  final _formKey = GlobalKey<FormState>();
  final List sugars = ["0", "1", "2", "3", "4"];

  String _currentName;
  String _currentSugars;
  int _currentStrength;
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          UserData userData = snapshot.data;
          return Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Update your brew settings",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                initialValue: userData.name,
                validator: (val) => val.isEmpty ? "Please enter a name" : null,
                onChanged: (val) => setState(() => _currentName = val),

              ),
              const SizedBox(height: 20,),
                  //dropdown
              DropdownButtonFormField(
                value: _currentSugars ?? userData.sugars,
                items: sugars.map((sugar)
                {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text("$sugar ${_sugarS(int.parse(sugar))}"),               
                  );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugars = val ),
              ),
              const SizedBox(height: 20,),
                  //slider
              Slider(
                min: 100.0,
                max: 900.0,
                divisions: 8,
                //label: "${_currentStrength/100}",
                value: (_currentStrength ?? userData.strength).toDouble(),
                activeColor: Colors.brown[_currentStrength ?? userData.strength],
                inactiveColor: Colors.blueGrey[_currentStrength ?? userData.strength],
                onChanged: (val) => setState(() => _currentStrength = val.round()),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  elevation: 6,
                  backgroundColor: Colors.brown[800],        
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white,)
                ),
                onPressed: () async
                {
                  if(_formKey.currentState.validate())
                  {
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars ?? userData.sugars, 
                      _currentName ?? userData.name, 
                      _currentStrength ?? userData.strength,
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
        }
        else
        {
          return Loading(shade: 0,);
        }

        
      }
    );
  }
}