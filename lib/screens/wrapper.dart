import 'package:flutter/material.dart';
import 'package:hello_me/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser?>(context);

    // return either Home or Authenticate widget
    if(user == null){
      return Authenticate();
    } else{
      return RandomWords();
    }
  }
}
