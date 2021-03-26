import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";

  @override
  Widget build(BuildContext context) {
  final String phone_number = ModalRoute.of(context).settings.arguments;

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP"),
      ),
      body: Body(phoneNumber: phone_number),
      floatingActionButton: callButton(),
    );
  }
}
