
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ required this.uid });

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brew');

  Future updateUserData(Set saved) async {
    return await brewCollection.doc(uid).set({
      'saved': saved,
    }
    );
  }
}