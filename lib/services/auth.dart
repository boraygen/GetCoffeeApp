import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_coffee_app/services/database.dart';


class AuthService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user stream
  Stream<User> get user 
  {
    return _auth.authStateChanges(); 
  }

  //sign in anon
  Future signIn_anon() async
  {
    try
    {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //sign in email pw
  Future signInWithEmailPw(String email, String password) async
  {
    try 
    {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) 
    {
      print(e.toString());
      return null;
    }
  }

  //register with email pw
  Future registerWithEmailPw(String email, String password) async
  {
    try 
    {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create a new doc for the user with uid
      await DatabaseService(uid: user.uid).updateUserData("0", "new member", 100);

      return user;
    } catch (e) 
    {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async
  {
    try 
    {
      return await _auth.signOut();
    } catch (e) 
    {
      print(e.toString());
      return null;
    }
  }
}