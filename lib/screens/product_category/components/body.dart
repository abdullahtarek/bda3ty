import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/home/components/home_header.dart';

import '../../../firestore_utils.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  final category_id;

  const Body({Key key, this.category_id}) : super(key: key);




  
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
                      future: getFireStoreCategoryProducts(category_id),
                      builder: (context, snapshot)
                      {
                        if (snapshot.data != null){
                          return GridViewProductWidget(productList: snapshot.data,);
                        }

                        return CircularProgressIndicator();
                      }
                  ),

                ])

        )
    );
  }
}
