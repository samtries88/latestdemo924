import 'package:demojune13/models/user.dart';
import 'package:demojune13/screens/authenticate/authenticate.dart';
import 'package:demojune13/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //accessing user data from provider
    //return either home or authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
