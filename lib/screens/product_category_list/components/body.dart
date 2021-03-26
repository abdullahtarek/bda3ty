import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/home/components/home_header.dart';
import 'package:shop_app/screens/home/components/special_offers.dart';
import 'package:shop_app/screens/product_category/product_category.dart';

import '../../../firestore_utils.dart';
import '../../../size_config.dart';

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
                  FutureBuilder(
                      future: getFireStoreCategories(),
                      builder: (context,snapshot) {
                        if (snapshot.data != null) {
                          return Column(
                            children: List.generate(
                              snapshot.data.length,
                                  (index) =>
                                  Container(
                                    margin: EdgeInsets.all(getProportionateScreenWidth(10)),
                                    child: SpecialOfferCard(
                                      image: snapshot.data[index].bannerPath,
                                      category: snapshot.data[index].name,
                                      numOfBrands: 18,
                                      press: () => Navigator.pushNamed(
                                        context,
                                        ProductCategory.routeName,
                                        arguments: ProductCategoryArguments(categoryid: snapshot.data[index].id,),
                                      ),
                                      width: 300,
                                      height: 132,
                                    ),
                                  ),

                            ),
                          );

                        }
                        return CircularProgressIndicator();
                      }

                  )

                ])

        )
    );
  }
}


