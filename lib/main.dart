
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_me/screens/authenticate/sign_in.dart';
import 'package:hello_me/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:hello_me/screens/services/auth.dart';
import 'package:hello_me/models/user.dart';
import 'package:hello_me/screens/wrapper.dart';

// void main() => runApp(const MyApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Scaffold(
            body: Center(
                child: Text(snapshot.error.toString(),
                    textDirection: TextDirection.ltr)));
      }
      if (snapshot.connectionState == ConnectionState.done) {
        return MyApp();
      }
      return const Center(child: CircularProgressIndicator());
        },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(          // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),                         // ... to here.
      home: StreamProvider<TheUser?>.value(
           initialData: null,
           value: AuthService().user,
           child: MaterialApp(
               initialRoute: '/home',
               routes: {
                 '/wrapper': (context) => Wrapper(),
                 '/home': (context) => RandomWords(),
             },
           ),
      ) // And add the const back here.
    );
  }
}



