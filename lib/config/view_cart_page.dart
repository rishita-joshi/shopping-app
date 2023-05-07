import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:recepie_task/config/product_model.dart';
import 'package:recepie_task/config/view_cart_controller.dart';

import 'database.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewCartController = Get.put(ViewCartContrller());
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: GetBuilder<ViewCartContrller>(builder: (context) {
            return FutureBuilder<List<ProductModel>>(
                future: DbManager().getModelList(true),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          children: [
                            Text(snapshot.data![index].id.toString()),
                            Text(snapshot.data![index].title.toString()),
                            Text(snapshot.data![index].category.toString()),
                          ],
                        );
                      }
                      return Text(snapshot.error.toString());
                    },
                  );
                });
          }),
        ),
      ]),
    );
  }
}
