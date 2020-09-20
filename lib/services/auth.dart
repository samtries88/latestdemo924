import 'package:demojune13/models/user.dart';
import 'package:demojune13/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {//auth service class is created

  final FirebaseAuth _auth = FirebaseAuth.instance; //_auth is an instance of firebase auth
//type FirebaseAuth comes from the package
  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) { //function called _userFromFirebaseUser is created that takes and input user from firebase, therefore in the bracket its of type firebase user
    return user != null ? User(uid: user.uid) : null; // since _userFromFirebaseUser is of type User it returns something of type User. Now the User property is defined with a constructor therefore you have it defined here in the bracket. Since you are returning a user from Firebase if the user is not null, for the User returned the uid of that user will be equal to the uid of the user received from firebase.
  } //returns a regular user from the user model created in user.dart
//when the function above is called, if there is a user returned from firebase, that means user is not null then the class user is called and the user returned from firebase is assigned a user id and a User is returned
  //auth change user stream
  Stream<User> get usr { //data we are getting back from stream is a firebase user
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser); // this function is called as AuthService().usr
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }
//firebase returns a stream of firebase user with it's onAuthStatechanged function.

  Future singInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();// the result is of type AuthResult
      FirebaseUser user = result.user; //this result is fed to the function below where it expects a firebase user
      return _userFromFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }

  // sign in annonymusly
  //sign in w email and password
  Future signInWithEmailAndPassword(String email, String password) async {

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }

  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async { //returns a future most like everything in this auth service
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create a new document for the user with the uid
      await DataBaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user); //returns a regular/Dart user (from the user model that we created) from the firebase user as the function _userfromfirebaseuser is called and the user from firebase is given as an input. the user from firebase is the user that comes from result.user
      // we want to make a request to firebase

    } catch (e){
      print(e.toString());
      return null;

    }

  }
  //sign out
    Future signOut () async { // because it takes some time to complete
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
    }
}