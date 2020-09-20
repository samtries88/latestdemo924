import 'package:demojune13/models/brew.dart';
import 'package:demojune13/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//there is going to be states in this widget that is why we use a stateful widget

//this is going to be the content
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context) ?? [];//fall back option if the brews are not loaded yet or else without ther ternary operator it will cycle through a null array
    //print(brews.documents); // this helps us see the instance of the snapshot in the terminal
   //some may have been deleted

    return ListView.builder(
      itemCount: brews.length,
        itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
        },
    );
  }
}
