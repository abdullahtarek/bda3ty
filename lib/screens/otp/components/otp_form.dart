import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/screens/sign_in/components/sign_form.dart';
import '../../../constants.dart';

String _verificationCode = verificationCode ;

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final b1 = TextEditingController();
    final b2 = TextEditingController();
    final b3 = TextEditingController();
    final b4 = TextEditingController();
    final b5 = TextEditingController();
    final b6 = TextEditingController();

    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  autofocus: true,
                  //obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: b1,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  //obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: b2,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  //obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: b3,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  //obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: b4,
                  onChanged: (value) => nextField(value, pin5FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  //obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: b5,
                  onChanged: (value) => nextField(value, pin6FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  //obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: b6,
                  onChanged: (value) {
                    if (value.length == 1) {
                      authenticateFromAnotherPhone(b1, b2, b3, b4, b5, b6);
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),


            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "استمر",
            press: () {
              authenticateFromAnotherPhone(b1, b2, b3, b4, b5, b6);

            },
          )
        ],
      ),
    );
  }

  void authenticateFromAnotherPhone(TextEditingController b1, TextEditingController b2, TextEditingController b3, TextEditingController b4, TextEditingController b5, TextEditingController b6) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    
    String input_code = b1.text + b2.text + b3.text+b4.text+b5.text+b6.text;
    print(input_code);
    print(_verificationCode);
    
    AuthCredential authCreds = PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: input_code);
    print("Verficiation startss hereee ====================================");
    
    auth.signInWithCredential(authCreds).then((UserCredential result) async {
      print("Validation code suceddeeddddddddddddddddddd");
      userId = result.user.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId',userId );

      await FirebaseFirestore.instance.collection('users').doc(userId).get().then(
              (doc) {
            if (doc.exists) {
              if (doc['state'] == "signUp") {
                return Navigator.pushNamed(context, SignUpScreen.routeName);
              }
              else {
                if (doc['state']=="notVerfied"){
                  return Navigator.pushNamed(context, HomeScreen.routeName);

                }
                else {
                  return Navigator.pushNamed(context, HomeScreen.routeName);
                }
              }
            }
            else {

              CollectionReference users = FirebaseFirestore.instance.collection('users');
              users.doc(userId).set({'state': "signUp"});

              return Navigator.pushNamed(context, SignUpScreen.routeName);
            }
          });
    }).catchError((e){
      print(e);
    });
  }

}
