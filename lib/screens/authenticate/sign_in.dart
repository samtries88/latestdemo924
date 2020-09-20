import 'package:demojune13/services/auth.dart';
import 'package:demojune13/shared/constants.dart';
import 'package:demojune13/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView}); // this is a constructor for a widget so this value needs to be passed to the widget itself and not state object

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false; //if loading is true then we will show the loading widget

  //text field state
  String email = '';
  String password = ''; // all these values are stored in the state
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Login'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.isEmpty ? 'Please check your email' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });//needs a validator properties from the fields && requires a null value to be           returned
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);//since can get null or a user therefore the result if of type                       dynamic
                    if (result == null){
                    setState(() {
                    error = 'Please check your credentials';
                    loading = false;
                    });
                    }
                    // we have a streams in the root widget listening for auth changes therefore the user gets registererd automatically on pressed and the user                     comes down the same stream as the user has registered. now that the user is back and the authstate is changed and signed in and thats why                        automatically it shows the home page.
                    }
                  },
                ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                )
              ],
            ))
      ),
    );
  }
}


//anon login Text('Sign in Anon'),
//            onPressed: () async {
//            dynamic result = await _auth.singInAnon(); // its dynamic becoz it can return a firebase user or null
//            if (result == null){
//    print('error signing in');
//    } else{
//              print('signed in');
//              print(result.uid);
//            }
//            }