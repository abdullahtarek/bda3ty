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

            FutureBuilder(
                future: getdata(),
                builder: (context, snapshot)
                {
                    if (snapshot.data != null){
                        return Text(snapshot.data);
                    }

                    return CircularProgressIndicator();
            }

            ),


            //Image.network("https://firebasestorage.googleapis.com/v0/b/bda3ty-a915c.appspot.com/o/products%2F3ykK1fvn2oyabNqD8BKA%2Fimage_1.jpg?alt=media&token=bb8121f7-f3de-436a-b2e7-e1acbde6db13"),

            ElevatedButton(onPressed: () async{
              print("Abdullah");

              List<Product2> products = await getFireStoreProducts();

              print(products[0].title);
              print(products[1].title);

              print(products[0].images);
              print(products[1].images);

            },
              child: Text("Button"),
            ),


            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(title: "Popular Products", press: () {}),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),


            Container(
              margin: EdgeInsets.only(left: getProportionateScreenWidth(15),right:getProportionateScreenWidth(10) ) ,
              child: GridView.count(
                //padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                physics: ScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: (3.3/5),
                children: [
                  ...List.generate(
                    3,
                        (index) {
                      if (demoProducts[index].isPopular)
                        return Container(
                            margin: EdgeInsets.all(getProportionateScreenWidth(10)),
                            child: ProductCardItem(product: demoProducts[index])
                        );

                      return SizedBox
                          .shrink(); // here by default width and height is 0
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            ),







            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
