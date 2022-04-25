import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_me/screens/home/home.dart';
import 'package:hello_me/screens/services/database.dart';

import '../../models/user.dart';


class AuthService {

  User? currUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  TheUser? _userFromFirebaseUser(User? user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  Stream<TheUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch(e){
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      currUser = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: currUser?.uid).updateUserData({});
      return _userFromFirebaseUser(currUser);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign out
  Future signOut(Set saved) async {
    try{
      await DatabaseService(uid: currUser?.uid).updateUserData(saved);
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }


}