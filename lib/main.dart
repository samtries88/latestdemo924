
import 'package:demojune13/models/user.dart';
import 'package:demojune13/screens/wrapper.dart';
import 'package:demojune13/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(//Provider container or widget that will provide a value of type <user>
      value: AuthService().usr,//this will be the value provided and comes from the auth.dart class
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}