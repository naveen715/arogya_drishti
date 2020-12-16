import 'package:arogyadrishti/registerform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'shared/loading.dart';
import 'package:sms_autofill/sms_autofill.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  BuildContext scaffoldContext;
  String phoneNo, smssent, verificationId,signature,i;
  bool Loading=false;
  String _code;
  int tap=1;
  String ver;
  FirebaseAuth auth =FirebaseAuth.instance;
  final _control = TextEditingController();
  TextEditingController myController = TextEditingController();
  void listenforcode()async{
    await SmsAutoFill().listenForCode;
  }

  Future<void> verifyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent= (String verId, int forceCodeResent) {
      this.verificationId = verId;
      ver=this.verificationId;
      setState(() {
        Loading=false;
      });
      smsCodeDialoge(context).then((value){
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess= (PhoneAuthCredential credential)async{
      await auth.signInWithCredential(credential).then((UserCredential value){
        if(value.user!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>registerform()));
        }
      });
    };
    final PhoneVerificationFailed verifyFailed= (FirebaseAuthException e){
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds:60),
      verificationCompleted : verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );}
  Future<bool> smsCodeDialoge(BuildContext context){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text('Enter OTP'),
            content: PinInputTextFormField(
              pinLength: 6,
              onChanged: (val){
                smssent=val;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: ()async{
                  final AuthCredential cred= PhoneAuthProvider.credential(verificationId: ver, smsCode: smssent);
                  final User user =(await FirebaseAuth.instance.signInWithCredential(cred)).user;
                  if(user != null){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=> registerform()),
                    );
                  }
                  if(user==null){
                    showDialog(context: context,builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("Warning!!!"),
                        content: Text("You entered wrong OTP Please try again , Thank You"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("ok"),
                            onPressed:(){
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
                  }
                  else return null;
                  },
                child: Text('Login',
                  style:TextStyle(color: Colors.black) ,),
              ),
            ],

          );
        }
    );
  }
  Future<void> signIn(String smsCode) async{
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,);
    print(_code);
    await FirebaseAuth.instance.signInWithCredential(
        credential).then((user) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => registerform(),),
      );
    }).catchError((e){
      print(e);
    });
  }
  @override
  void initState(){
    listenforcode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  if (Loading) {
      return loading();
    } else {
      return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.black,
          title: Text('\t\t Arogya Drishti',style: TextStyle(fontSize: 25),)
      ),
      body: Container(
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 100,),
              Image.asset("lib/logo.png"),
              SizedBox(height: 40,),
              Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(width: 2)),
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: _control,
                  onTap: ()async{
                    if(tap<=2) {
                      _control.text = await SmsAutoFill().hint;
                      tap=tap+1;
                    }
                  },
                  validator:(val){
                    if(val.isEmpty){
                      return "sorry this feild cant be empty";
                    }
                    if(val.length!=10){
                      return "Please enter your 10 digit phone number ";
                    }
                    else return null;
                  },
                  onChanged: (val){
                    setState(() {
                      i=val;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Please enter your Phone Number",
                    hintStyle: TextStyle(fontSize:17),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.android,color: Colors.cyan,),
                      onPressed: ()async{
                        _control.text=await SmsAutoFill().hint;
                      },
                    )
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                child: RaisedButton(
                  padding: EdgeInsets.all(5),
                 shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(90),side: BorderSide.none), 
                  onPressed:(){


                    if(_formkey.currentState.validate()){
                      if(i.length==10){
                        phoneNo="+91"+i;
                      }
                      if(i.length>10){
                        phoneNo=i;
                      }
                      verifyPhone();
                      setState(() {
                        Loading=true;
                      });
                    }
                    },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Get OTP', style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                  elevation: 7.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("*After this step you will be redirected for a captcha verification ",style: TextStyle(color: Colors.red[400]),),
              )
            ],
          ),
        ),
      )
    );
    }
  }
}

