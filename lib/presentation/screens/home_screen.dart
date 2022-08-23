import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/states.dart';
import 'package:la_vie/constants/colors.dart';
import 'package:la_vie/constants/constants.dart';
import 'package:la_vie/data/models/category_model.dart';
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
    var cubit = LaVieCubit.get(context);
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
                searchFormFeild(),
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
                    child: categoryTitleAndBody(mediaQueryWidth: mediaQueryWidth, mediaQueryHeight: mediaQueryHeight))),
          ],
        ),
      );
    },
    );
  }
}



