import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/states.dart';
import 'package:la_vie/constants/colors.dart';

import '../../business_logic/la_vie_cubit/cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit= LaVieCubit.get(context);
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<LaVieCubit, LaVieStates>(
        listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            if(cubit.userModel != null)
            Container(
              width: mediaQueryWidth,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.darken),
                  image: NetworkImage('https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png'),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        CircleAvatar(
                         backgroundImage: NetworkImage('https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png'),
                          radius: 55,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Asir Abdelhady',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 210,
                    child: Container(
                      width: mediaQueryWidth,
                      height: mediaQueryHeight - 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF6F6F6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mediaQueryWidth,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/points.png'),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text('You have 30 points!'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Edit Profile',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: mediaQueryWidth,
                    height: 60,
                    decoration:
                    BoxDecoration(
                        border: Border.all(color: lightGrey()),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/changeFeildIcon.png'))),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text('Change Name'),
                        SizedBox(
                          width: 107,
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: mediaQueryWidth,
                    height: 60,
                    decoration:
                    BoxDecoration(
                        border: Border.all(color: lightGrey()),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/changeFeildIcon.png'))),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text('Change Email'),
                        SizedBox(
                          width: 110,
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
