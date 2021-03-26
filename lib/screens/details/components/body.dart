import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/product_category/product_category.dart';
import 'package:shop_app/size_config.dart';

import '../../../constants.dart';
import '../../../main.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:fluttertoast/fluttertoast.dart';

int numberOfItems;

class Body extends StatelessWidget {
  final Product2 product;

  const Body({Key key, @required this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    numberOfItems = product.minQuantity;
    return 
      Column(
        children: [
      Expanded(
        child: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
              ],
            ),
          ),
        ],
    ),
      ),

    detailFooter(product: product),

        ]);
  }
}

class detailFooter extends StatelessWidget {
  const detailFooter({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product2 product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      child: Container(
          margin: EdgeInsets.only(top: getProportionateScreenWidth(5)),
          padding: EdgeInsets.only(top: getProportionateScreenWidth(2)),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF6F7F9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),

      child: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: getProportionateScreenWidth(5),
                                    right:getProportionateScreenWidth(20),
                                    bottom: getProportionateScreenWidth(2)
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                  children: <Widget>[
                    Text(" السعر للقطعة الواحدة: ",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: Colors.black,//kPrimaryColor,
                        ),
                    ),
                    Text("\$"+product.minPrice.toString(),
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.w900,
                        color: Colors.black,//kPrimaryColor,
                      ),
                    ),
                  ]),
            ),
          ),
    Container(
            margin: EdgeInsets.only(top: getProportionateScreenWidth(2),
                right:getProportionateScreenWidth(20),
                bottom: getProportionateScreenWidth(10)
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                  children: <Widget>[
                    Text(" الحد الأدنى للطلب "+product.minQuantity.toString() + " قطع",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.red,//kPrimaryColor,
                      ),
                    ),
                  ]),
            ),
          ),

          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNumberPicker(
                initialValue: product.minQuantity,
                maxValue: 1000,
                minValue: product.minQuantity,
                step: 1,
                onValue: (value) {
                  numberOfItems = value ;
                },
              ),

            SizedBox(
              width:  getProportionateScreenWidth(200),
              height: getProportionateScreenHeight(56),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: kPrimaryColor,
                onPressed: (){

                  cartItems.add(Cart(product: product, numOfItem: numberOfItems ) );
                  print(cartItems);

                  Navigator.pushNamed(
                    context,
                    ProductCategory.routeName,
                    arguments: ProductCategoryArguments(categoryid: product.categoryId),);


                  Fluttertoast.showToast(
                      msg: "تم إضافة المنتج إلى عربة التسوق",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );


                },
                child: Text(
                  "أضف إلى السلة",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.white,
                  ),
                ),
              ),
            )

          ],
        )
        ]
        ,
      )
      ),
    );
  }
}
