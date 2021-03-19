import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';



class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _store_name;
  String _store_address;
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
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStoreNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStoreAdressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                registerUser();

                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Directionality buildStoreAdressFormField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(

        minLines: 2,
        maxLines: 5,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.multiline,
        onSaved: (newValue) => _store_address = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kStoreAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            removeError(error: kStoreAddressNullError);
            addError(error: kStoreAddressNullError);
            return "";
          }
          removeError(error: kStoreAddressNullError);
          return null;
        },
        decoration: InputDecoration(
          labelText: "عنوان المتجر",
          hintText: "عنوان المتجر",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(14) ),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location\ point.svg"),
        ),
      ),
    );
  }

  Directionality buildStoreNameFormField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textAlign: TextAlign.right,
        keyboardType: TextInputType.text,
        onSaved: (newValue) => _store_name = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kStoreNameNullError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            removeError(error: kStoreNameNullError);
            addError(error: kStoreNameNullError);
            return "";
          }
          removeError(error: kStoreNameNullError);
          return null;
        },
        decoration: InputDecoration(
          labelText: "اسم المتجر",
          hintText: "اسم المتجر",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(14) ),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Shop\ Icon.svg"),
        ),
      ),
    );
  }

  Directionality buildNameFormField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textAlign: TextAlign.right,
        keyboardType: TextInputType.text,
        onSaved: (newValue) => _name = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNameNullError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            removeError(error: kNameNullError);
            addError(error: kNameNullError);
            return "";
          }
          removeError(error: kNameNullError);
          return null;
        },
        decoration: InputDecoration(
          labelText: "اسمك",
          hintText: "اسمك",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(14) ),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      ),
    );
  }

  void registerUser() async{
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then(
            (doc) {
          if (doc.exists)
          {
            print("exists");
            // When he successfully signs up

            FirebaseFirestore.instance.collection("users").doc(userId).set(
                {
                  "name": _name,
                  "storeName": _store_name,
                  "storeAddress": _store_address,
                  "state" : "unverfied"

                });



          }
          else{
            print("User Not found");
          }

        });



  }

}
