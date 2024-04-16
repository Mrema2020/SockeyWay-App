import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sockeyway/screens/authentication/register.dart';
import 'package:sockeyway/screens/dialogs/toast.dart';
import 'package:sockeyway/utils/colors.dart';
import 'package:sockeyway/utils/size_config.dart';

import '../home/welcome.dart';


 class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _message = '';
  bool isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController(text: "mkuu@gmail.com");
    _passwordController = TextEditingController(text: "123456");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor
      ),
      child: Scaffold(
        body: SafeArea(
            child: SizedBox(
              height: SizeConfig.heightMultiplier * 100,
              width: SizeConfig.widthMultiplier * 100,
              child: Stack(
                children: [
                  Container(
                    height: SizeConfig.heightMultiplier * 30,
                    width: SizeConfig.widthMultiplier * 100,
                    color: AppColors.primaryColor,
                    child: Center(
                      child: Text(
                        'Hi, Welcome Back!',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 3,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                      top: SizeConfig.heightMultiplier * 25,
                      child: Container(
                        height: SizeConfig.heightMultiplier * 70,
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: SizeConfig.heightMultiplier * 5),
                              Center(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 4,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor),
                                ),
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    color: AppColors.primaryColor),
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 5,
                                  child: TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: SizeConfig.textMultiplier * 1.5,
                                          color: AppColors.primaryColor
                                              .withOpacity(0.6)),
                                      hintText: 'Enter your email',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.4)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.2)),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: SizeConfig.heightMultiplier * 3),
                              Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    color: AppColors.primaryColor),
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 5,
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize:
                                            SizeConfig.textMultiplier * 1.5,
                                            color: AppColors.primaryColor
                                                .withOpacity(0.6)),
                                        hintText: 'Enter your password',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.4)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.2)),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.remove_red_eye_rounded,
                                            size: 20,
                                            color: AppColors.primaryColor,
                                          ),
                                        )),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password ?',
                                      style: TextStyle(
                                          fontSize: SizeConfig.textMultiplier * 2,
                                          color: AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _signInWithEmail();
                                  },
                                  child: Container(
                                    height: SizeConfig.heightMultiplier * 6,
                                    width: SizeConfig.widthMultiplier * 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: isLoading
                                      ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                                      : Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.textMultiplier * 2,
                                            color: AppColors.textColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'New User?',
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        color: AppColors.primaryColor),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize:
                                          SizeConfig.textMultiplier * 2,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  void _signInWithEmail() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _message = 'Welcome, ${userCredential.user?.displayName ?? 'Unknown user'}!';
        isLoading = false;
      });
      _emailController.clear();
      _passwordController.clear();
      Navigator.push(context, MaterialPageRoute(builder: (_) =>  const WelcomePage()));
      showToast(message: 'Login Successfully');

    } catch (e) {
      setState(() {
        _message = e.toString();
        isLoading = false;
      });
      showToast(message: '$e');
    }
  }
}