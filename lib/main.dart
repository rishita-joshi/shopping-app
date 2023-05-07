import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:recepie_task/config/database.dart';
import 'package:recepie_task/config/home_page.dart';
import 'package:recepie_task/config/http_config.dart';

DbManager dbManager = DbManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dbManager.openDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePages(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // DbManager handler = dbManager;
    // handler.initializedDB();
    HttPConfig().getProductData();
  }

  var itemList = ['Lunch', 'Dinner', 'BreakFast'];
  var backgroundColor = [
    Color.fromRGBO(247, 164, 164, 10.0),
    Color.fromRGBO(254, 190, 140, 10.0),
    Color.fromRGBO(211, 117, 107, 10.0),
  ];
  //var backgroundColor = []
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 40,
            child: Align(
              alignment: AlignmentDirectional.topEnd, // <-- SEE HERE
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_book),
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.search),
                    Expanded(
                      child: ListView.builder(
                          itemCount: itemList.length,
                          itemBuilder: ((context, index) {
                            return RotatedBox(
                                quarterTurns: 3,
                                child: SizedBox(
                                  width: 160,
                                  child: Text(
                                    itemList[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ));
                          })),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 60,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemCard(),
                    itemCard(),
                    itemCard(),
                    itemCard(),
                  ],
                ),
                Text("hellp"),
                Text("hellp"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  // width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Card(
                            color: backgroundColor[index],
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Noodles"),
                                  Text("Noodles"),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Hello"),
                                      Text("Hello"),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.abc)),
                                      Material(
                                        //Wrap with Material
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        elevation: 18.0,
                                        color: backgroundColor[index],
                                        clipBehavior:
                                            Clip.antiAlias, // Add This
                                        child: MaterialButton(
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: 40,
                                          color: backgroundColor[index],
                                          child: Text('View Profile ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.white)),
                                          onPressed: () {
//          setState(() {
//            _isNeedHelp = true;
//          });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        );
                      })),
                ),
                TextButton(
                  onPressed: () {
                 //   dbManager.getModelList();
                  },
                  child: Text("get data from db"),
                ),

                 TextButton(
                  onPressed: () {
                  //  dbManager.getModelList();
                  },
                  child: Text("get data from db"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  itemCard() {
    return Card(
      color: Color.fromRGBO(227, 242, 193, 10.0),
      child: Column(
        children: [
          Icon(Icons.abc),
          Text("hi"),
        ],
      ),
    );
  }
}
