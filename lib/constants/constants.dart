import 'package:flutter/material.dart';

enum SharedKeys{
  username,
  token,
  userId,
}

List<String> categories=[
  'All',
  'Plants',
  'Seeds',
  'Tools',
  'Products',
];

void getMediaSize(context){
  var mediaQueryHeight = MediaQuery.of(context).size.height;
  var mediaQueryWidth = MediaQuery.of(context).size.height;
}