
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demojune13/models/brew.dart';
import 'package:demojune13/models/user.dart';

class DataBaseService {

  final String uid; // this property is declared to provide uid from firebase to firestore
  DataBaseService({this.uid}); //therefore when we create an instance of DatabaseService we will have to pass in a uid due to the constructor we created.
  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews'); // of type collection reference. the name of the collection as specified in firebose database. same as the firebose console. Doesnt have to be created in firebase console directly. if this is called, then firebase creates a collection of this name if its not existing.
  //when user signs up we want to create a new document in the brews collection
  //we are going to use the uid provided by firebase to create a firestore brew document
  Future updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.document(uid).setData({
      'sugars': sugars, // the value on the left is the property defined in firestore
      'name': name, // the value on the right is what we will pass in when this func is called
      'strength': strength,
    }); //this func is called when the user signs up and checks the firestore document with this uid. Now if the firestore collection does not contain the uid, then it will create it. this func needs to be called when a user successfully signs up.
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) { //type of data is brew & takes in a query snapshot. When we receive snapshot down the stream that contains all the original data
    return snapshot.documents.map((doc){ //cycling through the documents and maps it into a different iterable. map is cycling through the doucments in doc
      return Brew( //returns a single brew object for that document and pass in the properties as specified in the brew class
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',//since its a map we can access single property by sq bracket
      );//so far it returns a iterable and we need to convert to lsit
    }).toList(); //converts the iterable to list

  }

  //user data from snapshot (firebase)
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

//get user doc stream - gets the documents of the current user
Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}

}