import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie/constants/colors.dart';
import 'package:la_vie/data/models/seeds_model.dart';
import 'package:la_vie/data/web_services/end_points.dart';
import '../../constants/constants.dart';
import '../../data/repository/cache_helper.dart';
import '../screens/login_screen.dart';

class laVieIcon extends StatelessWidget {
  const laVieIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      height: 100,
      width: 100,
      image: AssetImage('assets/images/La Vie Logo.png'),
    );
  }
}

class shopingCartButton extends StatelessWidget {
  const shopingCartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}


Widget defaultFormFeild({
  TextEditingController? controller,
  String? label,
  bool? isPassword = false,
  IconData? suffix,
  Function? suffixPressed,
  Function? onSubmit,
})=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(label!),
    ),
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        //onFieldSubmitted: onSubmit!(),
        obscureText: isPassword!,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter Valid data';
          }
        },
        decoration: InputDecoration(
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

Widget descriptionFormFeild({
  TextEditingController? controller,
  String? label,
  bool? isPassword = false,
  IconData? suffix,
  Function? suffixPressed,
  Function? onSubmit,
})=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(label!),
    ),
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 200,
        child: TextFormField(
          //onFieldSubmitted: onSubmit!(),
          obscureText: isPassword!,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Valid data';
            }
          },
          decoration: InputDecoration(
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
    ),
  ],
);

Widget defaultButton1({
  double width = double.infinity,
  required String text,
  bool isUpper = true,
  Color back = Colors.green,
  required Function onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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

Widget searchFormFeild({required double width}) => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Color(0xffdedddd)),
    width: width,
    height: 40,
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey,),
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

class defaultItemCard extends StatefulWidget {

  defaultItemCard({ this.title, this.price, this.image});

  String? title;
  String? price;
  String? image;


  @override
  State<defaultItemCard> createState() => _defaultItemCardState();
}

class _defaultItemCardState extends State<defaultItemCard> {
  int itemCounter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
          width: 150,
          child: Center(
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
                  bottom: 130,
                  left: 3,
                  child:Container(
                    width: 80,
                    height: 90,
                    decoration: BoxDecoration(
                      color: lightGrey(),
                      border: Border.all(
                        color: lightGrey()
                      ),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(BASEURL+widget.image!)
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  top: 78,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          if(itemCounter>1)
                          itemCounter--;
                          else
                            showToast(text: 'You need to buy atleats 1', color: Colors.yellow);
                        });

                      },
                      child: Icon(
                        Icons.minimize,
                        size: 25,
                        color: Colors.grey,
                      )),
                ),
                Positioned(
                    left: 110,
                    top: 83,
                    child: Text(
                      '$itemCounter',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Positioned(
                  left: 125,
                  top: 85,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          itemCounter++;
                        });
                      },
                      child: Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.grey,
                      )),
                ),
                Positioned(
                    top: 150,
                    left: 10,
                    child: Row(
                      children: [
                        Container(
                          width:140,
                          child: Text(
                            widget.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    top: 200,
                    left: 10,
                    child: '${widget.price} EGP' != null ? Text(
                      widget.price!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ) : Text('500 EGP')),
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
          ),
        );
  }
}
