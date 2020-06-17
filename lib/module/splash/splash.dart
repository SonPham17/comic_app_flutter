import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comicappflutter/shared/widget/scale_animation.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startApp();
  }

  _startApp() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/splash_screen.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          ScaleAnimation(
            child: Center(
              child: Text(
                'Novel Galaxy',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Pacifico',
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
