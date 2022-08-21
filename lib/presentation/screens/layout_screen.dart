import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/cubit.dart';
import 'package:la_vie/business_logic/la_vie_cubit/states.dart';
import 'package:la_vie/constants/constants.dart';
import 'package:la_vie/data/repository/cache_helper.dart';
import 'package:la_vie/presentation/screens/login_screen.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LaVieCubit, LaVieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LaVieCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xffF6F6F6),
          body: cubit.NavBarScreens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 400),
            buttonBackgroundColor: Colors.green,
            index: cubit.currentIndex,
            height: 55,
              onTap: (index){
              cubit.changeNavBarScreen(index);
              },
              items: [
                Icon(FluentIcons.leaf_two_24_regular,
                  color: cubit.currentIndex==0? Colors.white: Colors.black),
                Icon(FluentIcons.qr_code_28_regular,
                    color: cubit.currentIndex==1? Colors.white: Colors.black),
                Icon(FluentIcons.home_28_regular,
                    color: cubit.currentIndex==2? Colors.white: Colors.black),
                Icon(FluentIcons.alert_28_regular,
                    color: cubit.currentIndex==3? Colors.white: Colors.black),
                Icon(FluentIcons.person_28_regular,
                    color: cubit.currentIndex==4? Colors.white: Colors.black),
              ]),
        );
      },
    );
  }
}