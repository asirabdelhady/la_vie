import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie/business_logic/la_vie_cubit/cubit.dart';

import '../../constants/constants.dart';
import '../../data/repository/cache_helper.dart';
import '../screens/login_screen.dart';

Widget defaultFormField(
        {TextEditingController? controller,
        String? label,
        bool? isPassword = false,
        IconData? suffix,
        IconData? prefix,
        Function? suffixPressed,
        Function? onSubmit}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(label!),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            onFieldSubmitted: onSubmit!(),
            obscureText: isPassword!,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Valid data';
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(prefix),
              suffixIcon: suffix != null
                  ? IconButton(
                      onPressed: () => suffixPressed!(), icon: Icon(suffix))
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );

Widget defaultButton({
  double wid = double.infinity,
  required String text,
  bool isUpper = true,
  Color back = Colors.green,
  required Function onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: wid,
        decoration: BoxDecoration(
          color: back,
        ),
        child: TextButton(
          onPressed: () => onPressed(),
          child: Text(
            isUpper ? text.toUpperCase() : text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

Future<bool?> showToast({required text, required color}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => widget),
      (route) => false,
    );

void signOut(context) {
  CacheHelper.removeData(key: SharedKeys.token);
  navigateAndFinish(context, LoginScreen());
}

Widget searchFormFeild() => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Color(0xffdedddd)),
    width: 270,
    height: 40,
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          iconColor: Colors.grey,
          hintText: 'Search',
        ),
      ),
    ));

Widget bodyTabView() => DefaultTabController(
    length: 5,
    child: Column(
      children: [
         Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            isScrollable: true,
            tabs: [
              Text('All'),
              Text('Plants'),
              Text('Seeds'),
              Text('Tools'),
              Text('Products'),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorColor: Colors.green,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 500,
          child: TabBarView(children: [
            Column(
              children: [],
            ),
            Center(child: Text('Plants')),
            Center(child: Text('Seeds')),
            Center(child: Text('Tools')),
            Center(child: Text('Products')),
          ]),
        ),
      ],
    ));


/*
Widget categoryTitleBuilder({
  context,
  width,
  borderColor,
  textColor,
  backGroundColor,
})=> Container(
  height: 60,
  width: width,
  child: ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder:(context, index) => SizedBox(width: 12,),
      itemCount: categories.length ,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => TextButton(
        onPressed: (){
          LaVieCubit.get(context).changeCategoryTitle(index);
        },
        child: Container(
          width: 63,
          height: 35,
          child: Center(child: Text(categories[index], style: TextStyle(color: textColor),)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: categories[index]  Colors.green : Colors.grey ,
              border: Border.all(color: borderColor)
          ),
        ),
      )
  ),
);*/

Widget plantCard() => Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 75.0),
            child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 110,
            child: Image(image: AssetImage('assets/images/plant.png')),
          ),
          Positioned(
            left: 80,
            top: 85,
            child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.grey,
                )),
          ),
          Positioned(
              left: 110,
              top: 83,
              child: Text(
                '1',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
          Positioned(
            left: 125,
            top: 80,
            child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.minimize,
                  size: 25,
                  color: Colors.grey,
                )),
          ),
          Positioned(
              top: 170,
              left: 10,
              child: Text(
                'Title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              )),
          Positioned(
              top: 200,
              left: 10,
              child: Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
          Positioned(
              top: 225,
              left: 12,
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                    color: Color(0xff1ABC00),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )),
        ],
      ),
    );
