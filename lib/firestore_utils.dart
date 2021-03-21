import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app/models/Product.dart';


Future<String> getDownloadPathFromstore (String path) async {
  return await FirebaseStorage.instance.ref().child(path).getDownloadURL();
}

Future<List<String>> getFirestoreobjectFromPath(String path) async {
  List<String> imglist = <String>[];

  await FirebaseStorage.instance.ref(path).listAll().then((value) async{

    await Future.forEach(value.items, (element) async {
      imglist.add(await getDownloadPathFromstore(element.fullPath));
    });

  });

  return imglist;
}

Future<List<Product2>> getFireStoreProducts() async {

  return await FirebaseFirestore.instance.collection('products').limit(2).get().then((queryResult) async {
    List<Product2> productslist = <Product2>[];

    await Future.forEach(queryResult.docs, (element) async =>  productslist.add(
        Product2(
            element.id,
            element['arabicName'],
            element['description'],
            await getFirestoreobjectFromPath("products/"+element.id+"/"),
            element['minPrice'].toDouble(),
            element['maxPrice'].toDouble(),
            element['minQuantity'])
    ));

    return productslist;
  });

}

