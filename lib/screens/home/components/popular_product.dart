import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';





// class PopularProducts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: SectionTitle(title: "Popular Products", press: () {}),
//         ),
//         SizedBox(height: getProportionateScreenWidth(20)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.all(getProportionateScreenWidth(5)),
//           child: Row(
//             children: [
//               ...List.generate(
//                 demoProducts.length,
//                 (index) {
//                   if (demoProducts[index].isPopular)
//                     return ProductCard(product: demoProducts[index]);
//
//                   return SizedBox
//                       .shrink(); // here by default width and height is 0
//                 },
//               ),
//               SizedBox(width: getProportionateScreenWidth(20)),
//             ],
//           ),
//         ),
//         SizedBox(height: getProportionateScreenWidth(20)),
//
//       ],
//     );
//   }
// }


class PopularProducts2 extends StatelessWidget {

  final List<Product2> productList;

  const PopularProducts2({Key key, this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(title: "منتجات رائعة", press: () {}),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(getProportionateScreenWidth(5)),
          child: Row(
            children: [
              ...List.generate(
                productList.length,
                    (index) {
                  if (true)
                    return ProductCard(product: productList[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),

      ],
    );
  }
}
