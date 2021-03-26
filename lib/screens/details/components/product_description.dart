import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product2 product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Text(
              product.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                right: getProportionateScreenWidth(20),
                top: getProportionateScreenWidth(20),
                bottom: getProportionateScreenWidth(5),
              ),
              child: Text(
                  "وصف المنتج :",
                  style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w900,
                  color: Colors.black,//kPrimaryColor,
                  ),
              )
          ),

          Padding(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(20),
              left: getProportionateScreenWidth(64),
              bottom: getProportionateScreenWidth(10),
            ),
            child: Text(
              product.description,
              maxLines: 3,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: getProportionateScreenWidth(20),
          //     vertical: 10,
          //   ),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Row(
          //       children: [
          //         Text(
          //           "See More Detail",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w600, color: kPrimaryColor),
          //         ),
          //         SizedBox(width: 5),
          //         Icon(
          //           Icons.arrow_forward_ios,
          //           size: 12,
          //           color: kPrimaryColor,
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
