class User {
  final String uid; //string property

  User({this.uid}); // this is to turn firebase user to dart user & is a constructor

}

class UserData {

  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.name, this.sugars, this.strength});
}