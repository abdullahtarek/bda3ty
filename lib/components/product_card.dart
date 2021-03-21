import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product2 product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: ProductCardItem(product: product, widgetName: "popular_products"),

      ),
    );
  }
}

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    Key key,
    @required this.product, this.widgetName,
  }) : super(key: key);

  final Product2 product;
  final String widgetName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: ProductDetailsArguments(product: product),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),

        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widgetName+"_"+product.id.toString(),
                    child: Image.network(product.images[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                height: getProportionateScreenWidth(45) ,
                child: Text(
                  product.title,
                  style: TextStyle(color: Colors.black),
                  maxLines: 2,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${(product.minPrice).toStringAsFixed(1)} - \$${product.maxPrice.toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.w900,
                      color: Colors.black,//kPrimaryColor,
                    ),
                    maxLines: 2,
                  ),

                ],
              ),
              Text(
                " (الحد الأدنى) ${(product.minQuantity)} قطع ",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
