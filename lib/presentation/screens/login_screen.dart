import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/Login page background.png'),
              fit: BoxFit.cover,
            )),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child:
                      Image(image: AssetImage('assets/images/La Vie Logo.png')),
                ),
                Container(
                  height: 450,
                  width: double.infinity,
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        bottomOpacity: 1,
                        elevation: 0,
                        title: TabBar(
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
                      body: TabBarView(children: [
                        SingleChildScrollView(
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
                                onPressed: (){},),

                            ],
                          ),
                        ),
                        Column(
                          children: [
                            defaultFormField(
                              label: 'Email'
                            ),
                            defaultFormField(
                              label: 'Password'
                            ),
                            defaultButton(
                              text: 'Login',
                              onPressed: (){},),

                          ],
                        )
                      ]),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,20),
                  child: Row(
                      children: [
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
        ],
      ),
    );
  }
}
