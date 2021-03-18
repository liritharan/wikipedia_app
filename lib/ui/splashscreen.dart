import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wikipedia_app/ui/homepage.dart';



class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateToLoginScreen();
  }

  void navigateToLoginScreen() {
    Future.delayed(
        Duration(seconds: 3),
            () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomePage()));
        }
    );
  }


  @override
  Widget build(BuildContext context) {


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: NetworkImage(
                    "https://assets2.lottiefiles.com/packages/lf20_69HH48.json")),
          ),
        ),
      ),
    );
  }
}



