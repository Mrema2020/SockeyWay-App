import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sockeyway/screens/authentication/login.dart';

import '../../utils/size_config.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AnimationController controller;
  var appHeight;
  var appWidth;


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    Timer(const Duration(seconds: 4), _handleTimeout);
  }

  _handleTimeout () {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (_) =>
        const LoginPage(),
      ),
            (Route route) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.widthMultiplier * 100,
            child: Center(
              child: Image.asset('assets/sockeyway.png',
              width: SizeConfig.widthMultiplier * 40,
              ),
            ),
          ),
        ),
    );
  }
}
