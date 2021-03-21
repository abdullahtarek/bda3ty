import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/home/components/section_title.dart';

import '../../../firestore_utils.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';


Future<String> getdata() async {

  String ll = await Future.delayed(Duration(seconds: 3), () {
    return "Loading is Done";
  });

  return ll;
}


class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),

            SizedBox(height: getProportionateScreenWidth(30)),

            FutureBuilder(
                future: getFireStoreProducts(),
                builder: (context, snapshot)
                {
                  if (snapshot.data != null){
                    print(snapshot.data[0].images[0]);
                    return PopularProducts2(productList: snapshot.data,);
                  }

                  return CircularProgressIndicator();
                }
            ),


            // SizedBox(height: getProportionateScreenWidth(30)),
            // PopularProducts(),
            // SizedBox(height: getProportionateScreenWidth(30)),
            //
            // Container(
            //   margin: EdgeInsets.only(left: getProportionateScreenWidth(15),right:getProportionateScreenWidth(10) ) ,
            //   child: GridView.count(
            //     //padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            //     physics: ScrollPhysics(),
            //     crossAxisCount: 2,
            //     shrinkWrap: true,
            //     childAspectRatio: (3.3/5),
            //     children: [
            //       ...List.generate(
            //         3,
            //             (index) {
            //           if (demoProducts[index].isPopular)
            //             return Container(
            //                 margin: EdgeInsets.all(getProportionateScreenWidth(10)),
            //                 child: ProductCardItem(product: demoProducts[index])
            //             );
            //
            //           return SizedBox
            //               .shrink(); // here by default width and height is 0
            //         },
            //       ),
            //       SizedBox(width: getProportionateScreenWidth(20)),
            //     ],
            //   ),
            // ),


          ],
        ),
      ),
    );
  }
}
