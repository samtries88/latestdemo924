import 'package:demojune13/models/brew.dart';
import 'package:demojune13/screens/home/brew_list.dart';
import 'package:demojune13/screens/home/page1.dart';
import 'package:demojune13/screens/home/settings_form.dart';
import 'package:demojune13/services/auth.dart';
import 'package:demojune13/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool typing = false;

  final AuthService _auth = AuthService();
  @override

  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context, //this context comes the build method above
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DataBaseService().brews, //getting the instance of databseservice as the thing we are using does not need the uid
      //this stream wraps the rest of the widget tree
      //type of data getting down the stream (query snapshot) & comes from the firestore package
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(typing ? Icons.done : Icons.search),
              onPressed: () {
                setState(() {
                  typing = !typing;
                  
                });
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),

              ],
            ),
            title: typing ? TextField() : Text("Title"),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Logout'),
              onPressed: () async {
              await _auth.signOut(); // when this is pressed a null value is sent from firebase to dart therefore it will take you to the authenticate screen rather than home because of the stream in the root widget that is listening to any changes in the auth. Once signed out firebase sends no user and instead sends null down the stream and after listening to that, it automatically takes you to authenticate and you dont have to specify everytime on button pressed.

              },),
              FlatButton.icon(
                  onPressed: _showSettingsPanel, //we will call it on top as it needs the context
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),),
            ],
          ),
          body: TabBarView(
              children: [
                  BrewList(),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                      children: [
                      SettingsForm(),
                      ],
                  ),
                ),
          ],
          ),
        ),
      ),
    );
  }
}
