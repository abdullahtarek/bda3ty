import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../size_config.dart';

String verificationCode ='-9999';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String phone_number;
  String _verificationCode;
  TextEditingController _phone_number = TextEditingController();
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
       //   buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          // DefaultButton2(
          //   text: "تسجيل الدخول",
          //   press: () async {
          //     if (_formKey.currentState.validate()) {
          //       _formKey.currentState.save();
          //       // if all are valid then go to success screen
          //       KeyboardUtil.hideKeyboard(context);
          //
          //       String doc_id = "4lnadHg2Ejstd21XCLOR";
          //
          //       await FirebaseFirestore.instance.collection('users').doc(doc_id).get().then(
          //           (doc) {
          //             if (doc.exists)
          //               {
          //                 print("exists");
          //                 print(doc['name']);
          //                 // When he successfully signs up
          //                 FirebaseFirestore.instance.collection("users").doc(doc_id).set(
          //                     {
          //                       "name":"Abdullah",
          //                       "phoneNumber": "01009026001",
          //                       "storeAddress": "6 od october",
          //                       "storeName": "hamada",
          //                       "state" : "unverfied"
          //                     });
          //
          //
          //               }
          //             else{
          //               // when he goes to sign up page
          //               print("Dose not exist");
          //               FirebaseFirestore.instance.collection("users").doc(doc_id).set(
          //                   {
          //                     "phoneNumber": "01009026001",
          //                     "state" : "SignUp"
          //                   });
          //
          //             }
          //           });
          //
          //       print("heyyyyy");
          //
          //       //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
          //     }
          //   },
          //     color: kPrimaryColor
          // ),
          //SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton2(
            text: "إنشاء حساب / تسجيل الدخول",
            press: () {
              if (_formKey.currentState.validate()) {
                KeyboardUtil.hideKeyboard(context);
                _verifyPhone();
                Navigator.pushNamed(context, OtpScreen.routeName, arguments: _phone_number.text);
              }
            },
            color: kPrimaryColor
          ),

        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  Directionality buildPhoneFormField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: _phone_number,
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phone_number = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNullError);
          } else if (phoneValidationRegExp.hasMatch(value)) {
            removeError(error: kInvalidPhoneError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            removeError(error: kInvalidPhoneError);
            addError(error: kPhoneNullError);
            return "";
          } else if (!phoneValidationRegExp.hasMatch(value)) {
            addError(error: kInvalidPhoneError);
            return "";
          }
          removeError(error: kInvalidPhoneError);
          return null;
        },
        decoration: InputDecoration(
          labelText: "رقم الهاتف",
          hintText: "رقم الهاتف",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(14) ),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        ),
      ),
    );
  }

  _verifyPhone() async {
    print('+2${_phone_number.text}');
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+2${_phone_number.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {

              print("yyaaaaayyyy logged in ");

              userId = value.user.uid;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('userId',value.user.uid );


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

            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
            verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

}

