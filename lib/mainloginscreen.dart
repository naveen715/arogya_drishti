import 'package:arogyadrishti/main.dart';
import 'package:arogyadrishti/phoneauth.dart';
import 'package:arogyadrishti/registerform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'google_login.dart';
class SignInPage extends StatelessWidget {
  void _showButtonPressDialog(BuildContext context, String provider) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }
  @override
  Widget build(BuildContext context) {
    final FacebookLogin facebookSignIn = new FacebookLogin();


    Future<Null> _login() async {
      final FacebookLoginResult result =
      await facebookSignIn.logIn(['email']);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>registerform()));
          final FacebookAccessToken accessToken = result.accessToken;
          print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    }
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("lib/logo.png")
              ,
              SizedBox(height: 20,),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  signInWithGoogle().then((result){
                   if(result!=null){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>registerform()));
                   }
                  });
                },
              ),
              SizedBox(height: 20,),
              SignInButton(
                Buttons.FacebookNew,
                onPressed:()=>_login()
              ),
              SizedBox(height: 20,),
              SignInButton(
                Buttons.Twitter,
                text: "Use Twitter",
                onPressed: () {
                  _showButtonPressDialog(context, 'Twitter');
                },
              ),
              SizedBox(height: 20,),
              SignInButtonBuilder(
                text: 'Continue with phone',
                icon: Icons.phone,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()

                  ));
                },
                backgroundColor: Colors.cyan,
                width: 220.0,
              ),
              SizedBox(height: 20,),
              Text("Already a user ? Please Sign In",style: TextStyle(color: Colors.black,fontSize: 18),),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.black,
                child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 18),),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>null));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
