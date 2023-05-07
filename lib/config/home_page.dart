import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recepie_task/config/database.dart';
import 'package:recepie_task/config/http_config.dart';
import 'package:recepie_task/config/product_model.dart';
import 'package:recepie_task/config/view_cart_page.dart';

import 'home_page_controller.dart';

class HomePages extends StatelessWidget {
  HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(HomePageController());

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<HomePageController>(builder: (context) {
              return FutureBuilder<List<ProductModel>>(
                  future: DbManager().getModelList(false),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Row(
                            children: [
                              Text(snapshot.data![index].id.toString()),
                              snapshot.data![index].quantity < 1
                                  ? TextButton(
                                      onPressed: () {
                                        cartController.updateText(
                                            snapshot.data![index], true);
                                      },
                                      child: Text("Add"))
                                  : Container(
                                      color: Colors.green,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                cartController.updateText(
                                                    snapshot.data![index],
                                                    true);
                                              },
                                              icon: Icon(Icons.add)),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Text(snapshot.data![index].quantity
                                              .toString()),
                                          IconButton(
                                              onPressed: () {
                                                cartController.updateText(
                                                    snapshot.data![index],
                                                    false);
                                              },
                                              icon: Icon(Icons.minimize)),
                                        ],
                                      ),
                                    ),
                            ],
                          );
                        }
                        return Text(snapshot.error.toString());
                      },
                    );
                  });
            }),
          ),
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ViewPage();
                  },
                ));
              },
              child: Text("View Cart")),
        ],
      ),
    );
  }
}
