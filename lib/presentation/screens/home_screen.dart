import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/states.dart';
import 'package:la_vie/constants/colors.dart';
import 'package:la_vie/constants/constants.dart';
import 'package:la_vie/data/models/seeds_model.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';

import '../../business_logic/la_vie_cubit/cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LaVieCubit>(context,listen: true);
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    ScrollController parentScrollController = ScrollController();
    ScrollController childScrollController = ScrollController();
    return BlocConsumer<LaVieCubit, LaVieStates>(
      listener: (context, state) {
      },
    builder: (context, state) {
      return SingleChildScrollView(
        controller: parentScrollController,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            laVieIcon(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                searchFormFeild(width: 250),
                shopingCartButton(),
              ],
            ),
            SingleChildScrollView(
                controller: childScrollController,
                child: NotificationListener(
                  onNotification: (ScrollNotification notification){
                    if (notification is ScrollUpdateNotification) {
                      if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent) {
                        debugPrint('Reached the bottom');
                        parentScrollController.animateTo(
                            parentScrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds:300),
                            curve: Curves.easeIn);
                      } else if (notification.metrics.pixels ==
                          notification.metrics.minScrollExtent) {
                        debugPrint('Reached the top');
                        parentScrollController.animateTo(
                            parentScrollController.position.minScrollExtent,
                            duration: Duration(milliseconds:300),
                            curve: Curves.easeIn);
                      }
                    };
                    return true;
                  },
                  child: DefaultTabController(
                      initialIndex: 0,
                      length: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 12),
                        child: Column(
                          children: [
                            Container(
                              width: mediaQueryWidth,
                              height: 35,
                              child: TabBar(
                                tabs: [
                                  Text('All'),
                                  Text('Plants'),
                                  Text('Seeds'),
                                  Text('Tools'),
                                  Text('Products'),
                                ],
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.white,
                                labelColor: Colors.green,
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.green)
                                ),
                              ),
                            ),
                            if(cubit.seedsModel!=null)
                              Container(
                                width: double.infinity,
                                height: mediaQueryHeight,
                                child: TabBarView(children: [
                                  ConditionalBuilder(
                                      condition: state is! DataLoadingState,
                                      builder: (context) {
                                        return GridView.builder(
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 150/250,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) => defaultItemCard(
                                            title: '${cubit.productsModel!.data![index].name}',
                                            image: '${cubit.productsModel!.data![index].imageUrl}',
                                            price: '${cubit.productsModel!.data![index].price}',
                                          ),
                                          itemCount: cubit.productsModel!.data!.length,
                                        );
                                      }, fallback: (context)=> CircularProgressIndicator()),
                                  ConditionalBuilder(
                                      condition: state is! DataLoadingState,
                                      builder: (context) {
                                        return GridView.builder(
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 150/250,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) => defaultItemCard(
                                            title: '${cubit.plantsModel!.data![index].name}',
                                            image: '${cubit.plantsModel!.data![index].imageUrl}',
                                            price: '50 EGP',
                                          ),
                                          itemCount: cubit.plantsModel!.data!.length,
                                        );
                                      }, fallback: (context)=> CircularProgressIndicator()),
                                  ConditionalBuilder(
                                      condition: state is! DataLoadingState,
                                      builder: (context) {
                                        return GridView.builder(
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 150/250,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) => defaultItemCard(
                                            title: '${cubit.seedsModel!.data![index].name}',
                                            image: '${cubit.seedsModel!.data![index].imageUrl}',
                                            price: '50 EGP',
                                          ),
                                          itemCount: cubit.seedsModel!.data!.length,
                                        );
                                      }, fallback: (context)=> CircularProgressIndicator()),
                                  ConditionalBuilder(
                                      condition: state is! DataLoadingState,
                                      builder: (context) {
                                        return GridView.builder(
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 150/250,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) => defaultItemCard(
                                            title: '${cubit.toolsModels!.data![index].name}',
                                            image: '${cubit.toolsModels!.data![index].imageUrl}',
                                            price: '50 EGP',
                                          ),
                                          itemCount: cubit.toolsModels!.data!.length,
                                        );
                                      }, fallback: (context)=> CircularProgressIndicator()),
                                  ConditionalBuilder(
                                      condition: state is! DataLoadingState,
                                      builder: (context) {
                                        return GridView.builder(
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 150/250,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) => defaultItemCard(
                                            title: '${cubit.productsModel!.data![index].name}',
                                            image: '${cubit.productsModel!.data![index].imageUrl}',
                                            price: '${cubit.productsModel!.data![index].price}',
                                          ),
                                          itemCount: cubit.productsModel!.data!.length,
                                        );
                                      }, fallback: (context)=> CircularProgressIndicator()),
                                ]),
                              ),
                          ],
                        ),
                      )),
                )
            ),
          ],
        ),
      );
    },
    );
  }
}




