import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/constants/colors.dart';
import 'package:la_vie/constants/constants.dart';
import 'package:la_vie/data/models/category_model.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';

import '../../business_logic/la_vie_cubit/cubit.dart';

CategoryModel() {}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = LaVieCubit.get(context);
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            height: 100,
            width: 100,
            image: AssetImage('assets/images/La Vie Logo.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              searchFormFeild(),
              Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          DefaultTabController(
              initialIndex: 0,
              length: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: mediaQueryWidth,
                        height: 35,
                        child: TabBar(
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.white,
                          labelColor: Colors.grey,
                          isScrollable: true,
                          tabs: [
                            Text('All'),
                            Text('Plants'),
                            Text('Seeds'),
                            Text('Tools'),
                            Text('Products'),
                          ],
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.green)),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 600,
                      child: TabBarView(children: [
                        Container(
                          width: mediaQueryWidth,
                          height: 600,
                          child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4,
                                      childAspectRatio: 0.6),
                              itemBuilder: (context, index) => plantCard()),
                        ),
                        Center(child: Text('Plants')),
                        Center(child: Text('Seeds')),
                        Center(child: Text('Tools')),
                        Center(child: Text('Products')),
                      ]),
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
