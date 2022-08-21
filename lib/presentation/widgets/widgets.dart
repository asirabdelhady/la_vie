import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/constants.dart';
import '../../data/repository/cache_helper.dart';
import '../screens/login_screen.dart';

Widget defaultFormField({
  TextEditingController? controller,
  String? label,
  bool? isPassword = false,
  IconData? suffix,
  Function? suffixPressed
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(label!),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            obscureText: isPassword!,
            controller: controller,
            validator: (value) {
              if(value!.isEmpty){
                return 'Enter Valid data';
              }
            },
            decoration: InputDecoration(
              suffixIcon: suffix != null ? IconButton(
                onPressed: () => suffixPressed!(),
                  icon: Icon(suffix)) : null ,
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

Future<bool?> showToast({
  required text,
  required color
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);

void navigateTo(context, widget)=> Navigator.push(
  context,
  MaterialPageRoute(builder: (_)=> widget),
);

void navigateAndFinish(context, widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (_)=> widget),
  (route) => false,
);

void signOut(context){
  CacheHelper.removeData(key: SharedKeys.token);
  navigateAndFinish(context, LoginScreen());
}