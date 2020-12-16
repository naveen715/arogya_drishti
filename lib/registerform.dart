import 'package:arogyadrishti/mainloginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'shared/loading.dart';
class registerform extends StatefulWidget {
  @override
  _registerformState createState() => _registerformState();
}
class _registerformState extends State<registerform> {
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  String firstname;
  String midname;
  String lastname ;
  String state;
  String address;
  String city;
  String pincode;
  String Sex;
  String blood;
  String age;
  String mailid;
  String dob;
  bool Loading=false;
  final List<String> _sex=['Male','Female','Others'];
  final List<String> _blood=['A+','A-','AB+','AB-','B+','B-','O+','O-',];

  TextEditingController dateCtl = TextEditingController();
  container(String hinttext,String variablename,String imp){
    return Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(width: 1)),
      child: TextFormField(
        autofocus: false,
        style: TextStyle(decoration: TextDecoration.none),
          decoration: InputDecoration(
              icon:Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  child: Text(imp,style: TextStyle(color: Colors.red[300],fontSize: 20),),
                ),
              ),
              labelText: "  "+hinttext,
              border: InputBorder.none,
              hintText: "  "+hinttext),
        validator: (val) {
          if (val.isEmpty) {
            return "Sorry this field can't be blank";
          }
          return null;
        },
        onChanged: (val){
          setState(() => variablename=val);
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Loading?loading(): WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0.0,
          title:Text("Create or Update profile", style:TextStyle(fontSize: 22.0,fontFamily: "Merriweather"),),
        ),
        body: Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formkey,
                  autovalidate: false,
                  child: ListView(
                    children: <Widget>[
                      Image.asset("lib/logo.png"),
                      container("First Name", firstname,"*"),
                      SizedBox(height: 20,),
                      container("Middle Name",midname,""),
                      SizedBox(height: 20,),
                      container("Last Name",lastname,""),
                      SizedBox(height: 20,),
                      Container(
                        padding:EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(width: 1)),
                        child: TextFormField(
                          controller: dateCtl,
                          decoration: InputDecoration(
                            icon:Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                child: Text("*",style: TextStyle(color: Colors.red[300],fontSize: 20),),
                              ),
                            ),
                            border: InputBorder.none,
                            labelText: "Date of birth",
                            hintText: "Insert your dob",),
                          onTap: () async{
                            DateTime date = DateTime(1900);
                            FocusScope.of(context).requestFocus(new FocusNode());
                            date = await showDatePicker(
                                context: context,
                                initialDate:DateTime.now(),
                                firstDate:DateTime(1900),
                                lastDate: DateTime(2100));
                            dateCtl.text = date.toString().substring(0,11);
                            dob= date.toString().substring(0,11);
                            },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(width: 1)),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            icon:Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                child: Text("*",style: TextStyle(color: Colors.red[300],fontSize: 20),),
                              ),
                            ),
                            border: InputBorder.none,
                            labelText: "Sex",
                            hintText: "Sex",),
                          value: Sex,
                          onChanged: (val) => setState(() =>Sex = val),
                          items: _sex.map((difficulty) {
                            return DropdownMenuItem(
                              value: difficulty,
                              child: Text("$difficulty"),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(width: 1)),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            icon:Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                child: Text("*",style: TextStyle(color: Colors.red[300],fontSize: 20),),
                              ),
                            ),
                            border: InputBorder.none,
                            labelText: "Blood Gp.",
                            hintText: "Blood Gp.",),
                          value: blood,
                          onChanged: (val) => setState(() =>blood = val),
                          items: _blood.map((difficulty) {
                            return DropdownMenuItem(
                              value: difficulty,
                              child: Text("$difficulty"),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20,),
                      container("Address",address,""),
                      SizedBox(height: 20,),
                      container("State",state,""),
                      SizedBox(height: 20,),
                      container("City",city,""),
                      SizedBox(height: 20,),
                      container("Pin Code",pincode,""),
                      SizedBox(height: 20,),
                      Align(
                        child: RaisedButton(
                          color: Colors.cyan,
                          child: Text("Submit", style: const TextStyle(fontSize: 17.0,fontFamily: "Merriweather",color: Colors.black)),
                          onPressed: ()async{
                          },
                        ),
                      ),
                    ],
                  ),
                )
            )
    ));
  }
}
