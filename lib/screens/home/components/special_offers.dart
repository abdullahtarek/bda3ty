import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_category/product_category.dart';

import '../../../firestore_utils.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(
              title: "جميع الفئات",
              press: () {},
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:

            FutureBuilder(
            future: getFireStoreCategories(),
            builder: (context,snapshot) {
              if (snapshot.data != null) {
                return Row(
                  children: List.generate(
                    snapshot.data.length,
                        (index) =>
                    SpecialOfferCard(
                            image: snapshot.data[index].bannerPath,
                            category: snapshot.data[index].name,
                            numOfBrands: 18,
                            press: () => Navigator.pushNamed(
                              context,
                              ProductCategory.routeName,
                              arguments: ProductCategoryArguments(categoryid: snapshot.data[index].id,),
                            ),
                            width: 242,
                            height: 100,
                          ),

                  ),
                );

              }
              return CircularProgressIndicator();
            }

            )

        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.numOfBrands,
    @required this.press,
    @required this.width,
    @required this.height,

  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;
  final double width,height;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: GestureDetector(
          onTap: press,
          child: SizedBox(
            width: getProportionateScreenWidth(width),//300
            height: getProportionateScreenWidth(height),//132
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF343434).withOpacity(0.8),
                          Color(0xFF343434).withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15.0),
                      vertical: getProportionateScreenWidth(10),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "$category\n",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "$numOfBrands علامات التجارية ")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
