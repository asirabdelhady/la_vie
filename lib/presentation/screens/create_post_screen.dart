import 'dart:convert';
import 'dart:io' as IO;
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  File? image;

  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null) return;
      final bytes = await IO.File(image.path).readAsBytes();
      base64.encode(bytes);
      setState(() {
        print('encoded: ${base64Encode(bytes)}');
        print('${this.image}');
      });
    }on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
         leading: IconButton(onPressed: (){
           Navigator.pop(context);
         }, icon: Icon(Icons.arrow_back, color: Colors.black,),),
          title: Text('Create New Post', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 13,),
                      GestureDetector(
                        onTap: (){
                          pickImage();
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(Icons.add, color: Colors.green,),
                            Text('Add photo', style: TextStyle(color: Colors.green),)
                          ],),
                        ),
                      )
                    ],),
                  ],
                ),
              ),
              defaultFormFeild(label: 'Title', ),
              defaultFormFeild(label: 'Description'),
              defaultButton1(text: 'Post', onPressed: (){})
            ],
          ),
        ) ,
      ),
    );
  }
}
