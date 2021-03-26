import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/category.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../firestore_utils.dart';
import '../../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      floatingActionButton: callButton(),
    );
  }
}

class callButton extends StatelessWidget {
  const callButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () => launch('tel://01009026001'),
    child: SvgPicture.asset("assets/icons/Call.svg",color: Colors.black),

    );
  }
}
