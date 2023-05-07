import 'dart:async';
import 'package:path/path.dart';
import 'package:recepie_task/config/http_config.dart';
import 'package:recepie_task/config/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'product.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE productTable(id INTEGER PRIMARY KEY , quantity INTEGER, title TEXT ,price TEXT, description TEXT ,category TEXT, image TEXT ,rating TEXT )",
        );
      },
    );
  }

  Future insertModel(List<ProductModel> model) async {
    final Database db = await initializedDB();
    var result = 0;
    for (var planet in model) {
      result = await db.insert('productTable', planet.toJson());
      print(result);
    }
    return result;
  }

  Future<bool> tableIsEmpty() async {
    var db = await openDatabase('product.db');
    List map = await db.rawQuery('SELECT * FROM productTable');
    if (map.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProductModel>> getModelList(bool isVewCart) async {
    List<ProductModel> attraction = [];
    List<ProductModel> viewProductModel = [];
    final Database db = await initializedDB();
    final List<Map<String, dynamic>> maps = await db.query('productTable');
    List.generate(maps.length, (i) {
      attraction.add(ProductModel(
        id: maps[i]['id'],
        quantity: maps[i]['quantity'],
        category: maps[i]['category'],
        description: maps[i]['description'],
        image: maps[i]['image'],
        price: maps[i]['price'],
        rating: Rating(count: 1, rate: 1),
        title: maps[i]['title'],
      ));
      if (!isVewCart) {
        return attraction;
      } else {
        var listAttractive =
            attraction.where((element) => element.quantity > 1);
        listAttractive.forEach((element) {
          viewProductModel.add(element);
        });
        return viewProductModel;
      }
    });
    return attraction;
  }

  Future<int> updateModel(ProductModel model, bool isIncrement) async {
    final Database db = await initializedDB();
    int q;
    if (isIncrement) {
      q = model.quantity.toInt() + 1;
    } else {
      q = model.quantity.toInt() - 1;
    }
    final updateProductModel = ProductModel(
      quantity: q,
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      image: model.image,
      rating: model.rating,
    );

    int result = await db.update('productTable', updateProductModel.toJson(),
        where: "id =?", whereArgs: [model.id]);
    print(result);
    return result;
  }

  // Future<void> deleteModel(ProductModel model) async {
  //   await openDb();
  //   await database.delete('model', where: "id = ?", whereArgs: [model.id]);
  // }

  // getCartData() async {
  //   List<ProductModel> attraction = [];

  //   final Database db = await initializedDB();
  //   attraction = await db.rawQuery('SELECT * FROM productTable');
  //   result.where((ele))
  //   print("====>");
  //   print(result);
  // }
}
