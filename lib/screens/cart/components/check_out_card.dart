import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/product_category/product_category.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(10),
            //       height: getProportionateScreenWidth(40),
            //       width: getProportionateScreenWidth(40),
            //       decoration: BoxDecoration(
            //         color: Color(0xFFF5F6F9),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: SvgPicture.asset("assets/icons/receipt.svg"),
            //     ),
            //     Spacer(),
            //     Text("Add voucher code"),
            //     const SizedBox(width: 10),
            //     Icon(
            //       Icons.arrow_forward_ios,
            //       size: 12,
            //       color: kTextColor,
            //     )
            //   ],
            // ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "إجمالي الطلبات\n",
                    children: [
                      TextSpan(
                        text: ("\$"+getototal().toStringAsFixed(1)),
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "اتبع عملية الدفع",
                    press: () {


                      String bodyString= "";
                      cartItems.forEach((element) {
                        bodyString+= "product ID: " + element.product.id+"\n";
                        bodyString+= "product name: " + element.product.title+"\n";
                        bodyString+= "product quntity: " + element.numOfItem.toString() +"\n";
                        bodyString+= "\n";
                      });

                      CollectionReference orders = FirebaseFirestore.instance.collection('orders');
                      orders.add({'user': userId, "order": bodyString, "date": DateTime.now().toString() });

                      cartItems = [];

                      Navigator.pushNamed(
                        context,
                        HomeScreen.routeName,);


                      Fluttertoast.showToast(
                          msg: "تم استلام الطلب بنجاح",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );



                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
double getototal(){
  double total = 0;
  for (var value in cartItems) {
    total+= value.product.minPrice*value.numOfItem;
  }
  return total;
}