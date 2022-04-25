import 'package:flutter/material.dart';
import 'package:hello_me/screens/services/auth.dart';
import 'package:hello_me/screens/home/home.dart';

import '../../models/loading.dart';

class SignIn extends StatefulWidget {

  final Function? toggleView;
  SignIn({ required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                const Text(
                    'Welcome to Startup Names Generator, please log in below',
                    style: TextStyle(
                      //letterSpacing: 2.0,
                      // height: 5.0,
                      fontSize: 14.0,

                    )),
                const SizedBox(height: 30),
                TextFormField( //email
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                        setState(() => email = val);
                    },
                    decoration: const InputDecoration(
                       border: UnderlineInputBorder(),
                       hintText: 'Email'
                    ),
                  // enableSuggestions: false,
                  // autocorrect: false,
                ),
                const SizedBox(height: 20),
                TextFormField( // password
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  // enableSuggestions: false,
                  // autocorrect: false,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Password'
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 120.0),
                      elevation: 5.0,
                      primary: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    onPressed: () async {
                      setState(() => loading = true);
                      // dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      dynamic result = await _auth.signInAnon();
                      setState(() => loading = false);
                      if(result == null){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('There was an error logging into the app')));
                      } else{
                        setState(() => isLogIn = true);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 55.0),
                      elevation: 5.0,
                      primary: Colors.white,
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    onPressed: () async {
                      widget.toggleView!();
                    },
                    child: const Text('New user? Click to sign up'),
                  ),
                ),
                // TextButton.icon(
                //   icon: const Icon(
                //     Icons.person,
                //     color: Colors.white,
                //   ),
                //   label: const Text(
                //     'New user? Click to sign up',
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                //   onPressed: () {
                //     widget.toggleView!();
                //   },
                // ),
              ],
            ),
          ),
        )

        );
  }
}
