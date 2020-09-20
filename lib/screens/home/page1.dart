import 'package:demojune13/screens/home/brew_list.dart';
import 'package:demojune13/shared/constants.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: textInputDecoration,
        ),
        BrewList(),
      ],
    );
  }
}
