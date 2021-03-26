import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app/models/Product.dart';

import 'models/category.dart';


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

Future<List<Category>> getFireStoreCategories() async {
  return await FirebaseFirestore.instance.collection('category').get().then((queryResult) async {
    List<Category> categorylist = <Category>[];

    await Future.forEach(queryResult.docs, (element) async =>  categorylist.add(
        Category(
            element.id,
            element['arabicName'],
            await getDownloadPathFromstore(element['iconPath']),
        )
    ));

    return categorylist;
  });

}

Future<List<Product2>> getFireStoreCategoryProducts(String id) async {
  return await FirebaseFirestore.instance.collection('products').where("categoryId", isEqualTo: id ).limit(10).get().then((queryResult) async {
    List<Product2> productslist = <Product2>[];

    await Future.forEach(queryResult.docs, (element) async =>  productslist.add(
        Product2(
            element.id,
            element['arabicName'],
            element['description'],
            element['categoryId'],
            await getFirestoreobjectFromPath("products/"+element.id+"/"),
            element['minPrice'].toDouble(),
            element['maxPrice'].toDouble(),
            element['minQuantity'])
    ));

    return productslist;
  });

}


Future<List<Product2>> getFireStoreProducts() async {

  return await FirebaseFirestore.instance.collection('products').limit(10).get().then((queryResult) async {
    List<Product2> productslist = <Product2>[];

    await Future.forEach(queryResult.docs, (element) async =>  productslist.add(
        Product2(
            element.id,
            element['arabicName'],
            element['description'],
            element['categoryId'],
            await getFirestoreobjectFromPath("products/"+element.id+"/"),
            element['minPrice'].toDouble(),
            element['maxPrice'].toDouble(),
            element['minQuantity'])
    ));

    return productslist;
  });

}

