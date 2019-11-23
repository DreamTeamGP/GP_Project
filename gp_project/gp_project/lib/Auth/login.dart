import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gp_project/Auth/ResetPassword.dart';
import 'package:gp_project/Auth/line.dart';
import 'package:gp_project/Auth/signUp1.dart';
import 'package:gp_project/Home.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:gp_project/Auth/GlobalAuth.dart';
import 'package:gp_project/Pages/homepage.dart';


class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  ScrollController _scrollController = new ScrollController();

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FacebookLogin fbLogin = new FacebookLogin();
 

 // get https => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: Icon(Icons.dehaze, size: 30.0, color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 40.0, bottom: 0.0, right: 50.0, left: 22.0),
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 25.0, bottom: 5.0, right: 50.0, left: 22.0),
              child: TextFormField(
                validator: (input){
                  if (input.length < 6) {
                    return 'Your password need to be at least 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 0.0, right: 50.0, left: 35.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                    width: 80,
                  ),
                  ButtonTheme(
                    minWidth: 170,
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 20, left: 20),
                      onPressed:signIn,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                      color: Colors.cyan,
                      textColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                  ),
                  FlatButton(
                    textColor: Colors.grey,
                    onPressed: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ResetPassword()));
                    
                    },
                    child: Text('Forgot pasword?',
                        style: TextStyle(fontSize: 15.0)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Column(
                children: <Widget>[
                  CustomPaint(painter: Drawhorizontalline(false)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 150, top: 20),
              child: Row(
                children: <Widget>[
                  SignInButton(
                    Buttons.Facebook,
                    onPressed: loginWithFacebook,
                    //() {
                    //   fbLogin.isLoggedIn.
                    //   then((result){
                    //     switch(result.status){
                    //       case FacebookLoginStatus.loggedIn:
                    //       FirebaseAuth.instance.signInWithFacebook(
                    //         FacebookAccessToken : result.accessToken.token
                    //       ).then((signedInUser){
                    //         print('Sign in as ${signedInUser.displayName}');
                    //         Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                    //       }).catchError((e){
                    //         print(e);
                    //       });
                    //     }
                    //   }).catchError((e)
                    //   {print(e);}
                    //   )
                    //   ;
                     //},
                    mini: true,
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: _loginWithGoogle,
                    mini: true,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                children: <Widget>[
                  CustomPaint(painter: Drawhorizontallinee(false)),
                  FlatButton(
                    padding: EdgeInsets.only(left: 130),
                    textColor: Colors.grey,
                    onPressed:(){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => signUp1()));
                    },
                    child: Text('Dont have Account?',
                        style: TextStyle(fontSize: 18.0)),
                  ),
                  CustomPaint(painter: Drawhorizontallineee(false)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn()async{
      final FormState = _formKey.currentState;

      if (FormState.validate()){
        FormState.save();
        try{
          AuthResult user =  await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
         password:_password ) ;
         Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
        }
        catch(e){
          print(e.message);
        }
        
      } 
    }

  
 Future<FirebaseUser> loginWithFacebook() async {
    final facebookLogin = new FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('CANCELED BY USER');
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
    //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));

  }

      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = new GoogleSignIn();

      Future<FirebaseUser> _loginWithGoogle() async{

        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        try{
          AuthResult userDetails = await _firebaseAuth.signInWithCredential(credential);
        ProviderDetails providerInfo = new ProviderDetails(userDetails.user.providerId);

        List<ProviderDetails> providerData = new List<ProviderDetails>();
        providerData.add(providerInfo);

        UserDetails details = new UserDetails(
        userDetails.user.providerId,
        userDetails.user.displayName,
        userDetails.user.photoUrl,
        userDetails.user.email,
        providerData,
        );
        Navigator.push(context,
       MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
        }catch(e){
          print(e);
        }
        
      //return userDetails;
 }


  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}





class UserDetails{
  final String providerDetails;
  final String username;
  final String photoURL;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails , this.username , this.photoURL , this.userEmail , this.providerData);
}
class ProviderDetails{
  ProviderDetails(this.providerDetails);
  final String providerDetails;
  
}