import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';

import '../../constants.dart';
import '../../models/Product.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F6F9) ,
      ),

      backgroundColor: Color(0xFFF5F6F9),
      //appBar: CustomAppBar(rating: agrs.product.rating),
      body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  final Product2 product;

  ProductDetailsArguments({@required this.product});
}
