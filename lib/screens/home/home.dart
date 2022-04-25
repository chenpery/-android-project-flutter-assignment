import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import '../../models/user.dart';
import '../services/auth.dart';
import '../wrapper.dart';

bool isLogIn = false;

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[]; // NEW
  final _saved = <WordPair>{}; // NEW
  final _biggerFont = const TextStyle(fontSize: 18.0); // NEW


  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return Dismissible(
                child: ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                ),
                background: Container(
                    color: Colors.deepPurple,
                    child: Row(
                        children:
                        const <Widget>[
                          Icon(Icons.delete),
                          Text('Delete Suggestion'),
                        ]
                    )
                ),
                key: const Key('pair'),
                onDismissed: (DismissDirection direction) {
                    setState(() {
                      _saved.remove(pair);
                    });
                },
                confirmDismiss: (DismissDirection direction) async {
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text('Deletion is not implemented yet')));
                  bool? response = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Suggestion'),
                        content: const Text(
                            'Are you sure you want to delete TourHand from your saved suggestions?'),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: const Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                //setState(() => to_delete = true);
                              }
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                              //setState(() => to_delete = false);
                            }
                          ),
                        ],
                      );
                    },
                  );
                  // if(response == true) {
                  //     setState(() {
                  //       _saved.remove(pair);
                  //   });
                  //   }
                  return null;
                },
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text('Deletion is not implemented yet')));
                  // return null;
                // onDismissed: (direction) {
                //     setState(() {
                //       _saved.remove(pair);
                //     });
                // },
              );
            },
          );

          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Add from here...
      appBar: AppBar(
        title: const Text(
            'Startup Name Generator'
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.star),
            color: Colors.white,
            onPressed: () {
              _pushSaved();
            },
          ),
          const SizedBox(width: 10.0),
          IconButton(
            icon: isLogIn ? const Icon(Icons.exit_to_app) : const Icon(Icons.login),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () async {
              if(isLogIn) {
                await _auth.signOut(_saved);
                setState(() => isLogIn = false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully logged out')));
                setState(() => _saved.clear() );
              } else{
                print('OKKKKK');
                Navigator.pushNamed(context, '/wrapper');
              }
              // handle the press
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }

          final alreadySaved = _saved.contains(_suggestions[index]);

          // #docregion listTile
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.star : Icons.star_border,
              color: alreadySaved ? Colors.deepPurple : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
          // #enddocregion listTile
        },
      ),
      // #enddocregion itemBuilder
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);


  @override
  _RandomWordsState createState() => _RandomWordsState();
}
