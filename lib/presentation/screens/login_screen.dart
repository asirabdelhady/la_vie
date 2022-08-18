import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/cubit/cubit.dart';
import 'package:la_vie/business_logic/cubit/states.dart';
import 'package:la_vie/data/web_services/end_points.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Login page background.png'),
                        fit: BoxFit.cover,
                      )),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child:
                          Image(image: AssetImage('assets/images/La Vie Logo.png')),
                        ),
                        SizedBox(
                          height: 450,
                          width: double.infinity,
                          child: DefaultTabController(
                            length: 2,
                            child: Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.transparent,
                                bottomOpacity: 1,
                                elevation: 0,
                                title: const TabBar(
                                    unselectedLabelColor: Colors.grey,
                                    labelColor: Color(0xff1ABC00),
                                    indicatorColor: Color(0xff1ABC00),
                                    tabs: [
                                      Tab(
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(),
                                        ),
                                      ),
                                      Tab(
                                        child: Text('Login'),
                                      )
                                    ]),
                              ),
                              body: TabBarView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          defaultFormField(
                                              label: 'First Name'
                                          ),
                                          defaultFormField(
                                              label: 'Last Name'
                                          ),
                                          defaultFormField(
                                              label: 'Email'
                                          ),
                                          defaultFormField(
                                              label: 'Password'
                                          ),
                                          defaultFormField(
                                              label: 'Comfirm Password'
                                          ),
                                          defaultButton(
                                            text: 'Sign Up',
                                            onPressed: (){if(_formKey.currentState!.validate()){
                                              print('Proccesing Data');
                                            }
                                            },),

                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          defaultFormField(
                                            controller: emailController,
                                              label: 'Email'
                                          ),
                                          defaultFormField(
                                            controller: passwordController,
                                              label: 'Password',
                                          ),
                                          ConditionalBuilder(
                                            condition:state is! LoginLoadingState  ,
                                            builder: (context) =>defaultButton(
                                                text: 'Login',
                                                onPressed: (){
                                                  if(_formKey.currentState!.validate()){
                                                    LoginCubit.get(context).userLogin(
                                                      email: emailController.text,
                                                      password: passwordController.text,
                                                    );
                                                  }

                                                }
                                            ),
                                            fallback: (context)=> CircularProgressIndicator(),
                                          ),

                                        ],
                                      ),
                                    )
                                  ]),

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,20,20),
                          child: Row(
                              children: const [
                                Expanded(
                                    child: Divider(
                                      color: Color(0xff8A8A8A),
                                    )
                                ),
                                Text("or continue with"),
                                Expanded(
                                    child: Divider(
                                      color: Color(0xff8A8A8A),
                                    )
                                ),
                              ]
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){}, icon: Image.asset('assets/images/Google.png'),),
                            IconButton(onPressed: (){}, icon: Image.asset('assets/images/Facebook.png'),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
