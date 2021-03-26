import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/product_category/product_category.dart';

import '../../../firestore_utils.dart';
import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> categories = [
    //   {"icon": "assets/icons/Flash Icon.svg", "text": "موبايلات وتابلت"},
    //   {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
    //   {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
    //   {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
    //   {"icon": "assets/icons/Discover.svg", "text": "More"},
    // ];



    return FutureBuilder(
        future: getFireStoreCategories(),
        builder: (context,snapshot)
        {
          if (snapshot.data != null) {

            return Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  snapshot.data.length,
                      (index) =>
                      CategoryCard(
                        icon: snapshot.data[index].iconPath,
                        text: snapshot.data[index].name,
                        press: () => Navigator.pushNamed(
                          context,
                          ProductCategory.routeName,
                          arguments: ProductCategoryArguments(categoryid: snapshot.data[index].id,),
                        ),
                      ),
                ),
              ),
            );
          }

          return CircularProgressIndicator();

        }

        );
        }
  }

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.network(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
