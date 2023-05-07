import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:recepie_task/config/database.dart';
import 'package:recepie_task/config/product_model.dart';
import 'package:recepie_task/main.dart';
import 'package:sqflite/sqflite.dart';

class HttPConfig {
  DbManager handler = DbManager();
  static const String API_BASE = "https://fakestoreapi.com/products/";

  getProductData() async {
    final response = await http.get(
      Uri.parse(API_BASE),
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      List<ProductModel> productModelList = [];
      for (var singleProduct in parsed) {
        ProductModel productModel = ProductModel(
            quantity: 0,
            id: singleProduct['id'],
            title: singleProduct['title'],
            price: singleProduct['price'],
            description: singleProduct['description'],
            category: singleProduct['category'],
            image: singleProduct['image'],
            rating: Rating(
                count: singleProduct['rating']['count'],
                rate: singleProduct['rating']['rate']));
        productModelList.add(productModel);
      }
      bool isSaved = await handler.tableIsEmpty();
      if (isSaved) {
        return await handler.insertModel(productModelList);
      }
    }
  }
}
