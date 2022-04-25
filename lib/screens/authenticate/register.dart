import 'package:flutter/material.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {

  final Function? toggleView;
  Register({ required this.toggleView });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                widget.toggleView!();
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                TextFormField( //email
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Enter an email";
                    }
                    return null;
                  },
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
                  validator: (String? value) {
                    if (value != null && value.length < 6 ) {
                      return "Enter a password 6+ chars long";
                    }
                    return null;
                  },
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
                          vertical: 10.0, horizontal: 110.0),
                      elevation: 5.0,
                      primary: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if(result == null){
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('There was an error logging into the app')));
                          });
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        )

    );
  }
}

    