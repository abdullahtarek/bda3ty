import 'package:flutter/cupertino.dart';

class Category {
  String id;
  String name;
  String iconPath;
  String bannerPath;

  Category(
      @required this.id,
      @required this.name,
      @required this.iconPath,
      @required this.bannerPath,
      );
}