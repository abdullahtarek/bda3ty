import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';

import '../../enums.dart';
import 'components/body.dart';

class ProductCategory extends StatelessWidget {
  static String routeName = "/pcategory";

  @override
  Widget build(BuildContext context) {
    final ProductCategoryArguments args = ModalRoute.of(context).settings.arguments;
    print(args.categoryid);
    return Scaffold(
      body: Body(category_id: args.categoryid),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),

    );

  }
}


class ProductCategoryArguments {
  final String categoryid;

  ProductCategoryArguments({@required this.categoryid});
}
