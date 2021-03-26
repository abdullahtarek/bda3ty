import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cart.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(200),
              child: Text(

                cart.product.title,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
            ),
            SizedBox(height: 10),

            Row(
              children: [

                Text("${cart.numOfItem} x ",
                  style: Theme.of(context).textTheme.bodyText1,

                ),
                 Text("\$${cart.product.minPrice}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),

                  ),




              ],

            ),
          ],
        )
      ],
    );
  }
}
