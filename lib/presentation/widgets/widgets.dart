import 'package:flutter/material.dart';

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
