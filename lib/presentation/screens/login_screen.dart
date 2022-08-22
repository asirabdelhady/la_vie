
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie/business_logic/registration_cubit/cubit.dart';
import 'package:la_vie/business_logic/registration_cubit/states.dart';
import 'package:la_vie/constants/constants.dart';
import 'package:la_vie/data/repository/cache_helper.dart';
import 'package:la_vie/presentation/screens/layout_screen.dart';
import '../../business_logic/login_cubit/cubit.dart';
import '../../business_logic/login_cubit/states.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      initialIndex: 1,
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
                              BlocConsumer<RegistrationCubit, RegistrationStates>(
                                listener: (context, state) {
                                  if(state is RegistrationSuccessState){
                                    if(state.registrationModel.type == 'Success'){
                                      CacheHelper.saveData(
                                          key: SharedKeys.token,
                                          value: state.registrationModel.data?.accessToken
                                      );
                                      print(CacheHelper.getData(key: SharedKeys.token));
                                      navigateAndFinish(context, LayoutScreen());
                                    }
                                  }else if (state is RegistrationErrorState) {
                                    Fluttertoast.showToast(
                                        msg:'Check your data and try again',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        defaultFormFeild(
                                            controller: firstNameController,
                                            label: 'First Name'
                                        ),
                                        defaultFormFeild(
                                            controller: lastNameController,
                                            label: 'Last Name'
                                        ),
                                        defaultFormFeild(
                                            controller: emailController,
                                            label: 'Email'
                                        ),
                                        defaultFormFeild(
                                            isPassword: isPassword,
                                            controller: passwordController,
                                            suffixPressed: (){
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                                            label: 'Password'
                                        ),
                                        defaultFormFeild(
                                            isPassword: isPassword,
                                            controller: confirmPasswordController,
                                            suffixPressed: (){
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                                            label: 'Confirm Password'
                                        ),
                                        ConditionalBuilder(
                                          condition:state is! RegistrationLoadingState  ,
                                          builder: (context) =>defaultButton1(
                                              text: 'SIGN UP',
                                              onPressed: (){

                                                if(_formKey.currentState!.validate()){
                                                  RegistrationCubit.get(context).userRegistration(
                                                    confirmPassword: confirmPasswordController.text,
                                                    firstName: firstNameController.text,
                                                    lastName: lastNameController.text,
                                                    email: emailController.text,
                                                    password: passwordController.text,
                                                  );
                                                }
                                              }
                                          ),
                                          fallback: (context)=> const CircularProgressIndicator(),
                                        ),

                                      ],
                                    ),
                                  );
                                },
                              ),
                              BlocConsumer<LoginCubit, LoginStates>(
                                listener: (context, state){
                                  if(state is LoginSuccessState){
                                    if(state.loginModel.type == 'Success'){
                                      CacheHelper.saveData(
                                          key: SharedKeys.token,
                                          value: state.loginModel.data?.accessToken
                                      );
                                      print(CacheHelper.getData(key: SharedKeys.token));
                                      navigateAndFinish(context, LayoutScreen());
                                    }
                                  }else if (state is LoginErrorState) {
                                    showToast(
                                      text: 'Check your data and try again',
                                      color: Colors.red,
                                    );
                                  }
                                },
                                builder: (context, state){
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        defaultFormFeild(
                                          controller: emailController,
                                          label: 'Email',
                                        ),
                                        defaultFormFeild(
                                          suffixPressed: (){
                                            setState(() {
                                              isPassword = !isPassword;
                                            });
                                          },
                                          suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                                          isPassword: isPassword,
                                          controller: passwordController,
                                          label: 'Password',
                                        ),
                                        ConditionalBuilder(
                                          condition: state is! LoginLoadingState  ,
                                          builder: (context) => defaultButton1(
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
                                          fallback: (context)=> const CircularProgressIndicator(),
                                        ),

                                      ],
                                    ),
                                  );
                                },
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
  }
}
