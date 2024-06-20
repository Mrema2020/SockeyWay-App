import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sockeyway/screens/dialogs/toast.dart';
import 'package:sockeyway/screens/home/welcome.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth1 = FirebaseAuth.instance;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _message = '';
  String? _selectedType;
  bool isLoading = false;
  bool _obscureText = true;
  final List<String> _loginType = <String>['Player', 'Fan'];

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor, statusBarIconBrightness: Brightness.light),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: SizeConfig.heightMultiplier * 12,
                          width: SizeConfig.widthMultiplier * 40,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              "assets/sockeyway.png",
                              height: SizeConfig.heightMultiplier * 6,
                              width: SizeConfig.widthMultiplier * 20,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5, right: SizeConfig.widthMultiplier * 5),
                      child: ListView(
                        children: [
                          SizedBox(height: SizeConfig.heightMultiplier * 3),
                          Text(
                            'Name',
                            style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor),
                          ),
                          SizedBox(
                              height: SizeConfig.heightMultiplier * 5,
                              child: TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor.withOpacity(0.6)),
                                  hintText: 'Username',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xFF0B7689).withOpacity(0.2)),
                                  ),
                                ),
                              )),
                          SizedBox(height: SizeConfig.heightMultiplier * 3),
                          Text(
                            'Role',
                            style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor),
                          ),
                          DropdownButtonFormField<String>(
                            hint: Text(
                              'Register as',
                              style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor.withOpacity(0.6)),
                            ),
                            items: _loginType.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 15,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedType = newValue;
                              });
                            },
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 3),
                          Text(
                            'Email',
                            style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor),
                          ),
                          SizedBox(
                              height: SizeConfig.heightMultiplier * 5,
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor.withOpacity(0.6)),
                                  hintText: 'Enter your email',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.2)),
                                  ),
                                ),
                              )),
                          SizedBox(height: SizeConfig.heightMultiplier * 3),
                          Text(
                            'Password',
                            style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor),
                          ),
                          SizedBox(
                              height: SizeConfig.heightMultiplier * 5,
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor.withOpacity(0.6)),
                                  hintText: 'Enter your password',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.2)),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _toggle();
                                      },
                                      icon: _obscureText
                                          ? const Icon(
                                              CupertinoIcons.eye_slash_fill,
                                              size: 20,
                                              color: AppColors.primaryColor,
                                            )
                                          : const Icon(
                                              CupertinoIcons.eye,
                                              size: 20,
                                              color: AppColors.primaryColor,
                                            )),
                                ),
                              )),
                          SizedBox(height: SizeConfig.heightMultiplier * 5),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                _validate();
                              },
                              child: Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: SizeConfig.widthMultiplier * 50,
                                decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: isLoading
                                      ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                      : Text(
                                          'Sign Up',
                                          style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.textColor),
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
                                'Already have an Account?',
                                style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }

  void _signUpWithEmail() async {
    try {
      UserCredential userCredential = await _auth1.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Save username in user's profile
      await userCredential.user?.updateProfile(displayName: _usernameController.text.trim());
      await userCredential.user?.updatePhotoURL(_selectedType);
      setState(() {
        _message = 'User ${_usernameController.text.trim()} registered';
        isLoading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (_) => const WelcomePage()));
      showToast(message: "Registration Successfully");
    } catch (e) {
      print("Message = $_message");
      setState(() {
        _message = e.toString();
        isLoading = false;
      });
      if (_message ==
              "[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred." &&
          context.mounted) {
        Flushbar(
          title: "Network Error",
          message: "Please connect to internet",
          duration: const Duration(seconds: 3),
          backgroundColor: const Color(0Xffc71f37),
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(15),
          icon: const Icon(
            Icons.warning,
            color: Colors.white,
          ),
        ).show(context);
      } else if (context.mounted) {
        Flushbar(
          title: "Error",
          message: "$e",
          duration: const Duration(seconds: 3),
          backgroundColor: const Color(0Xffc71f37),
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(15),
          icon: const Icon(
            Icons.warning,
            color: Colors.white,
          ),
        ).show(context);
      }
    }
  }

  _validate() {
    if (_usernameController.text.trim() == "") {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        title: "Username missing",
        message: "Please enter your username to continue",
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0Xffc71f37),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(15),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      ).show(context);
    } else if (_selectedType == null) {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        title: "Role is missing",
        message: "Please select your role to continue",
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0Xffc71f37),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(15),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      ).show(context);
    } else if (_emailController.text.trim() == "") {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        title: "Email missing",
        message: "Please enter your email to continue",
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0Xffc71f37),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(15),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      ).show(context);
    } else if (_passwordController.text.trim() == "") {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        title: "Password missing",
        message: "Please your password to continue",
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0Xffc71f37),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(15),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      ).show(context);
    } else if (_passwordController.text.trim().length < 6) {
      setState(() {
        isLoading = false;
        _passwordController.clear();
      });
      Flushbar(
        title: "Short password",
        message: "Password must contain more than six(6) characters",
        duration: const Duration(seconds: 4),
        backgroundColor: const Color(0Xffc71f37),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(15),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      ).show(context);
    } else {
      _signUpWithEmail();
    }
  }
}
