import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:walktestapp/homepage.dart';






void main() {

  runApp(Main());
  }

class Main extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder:()=> MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.orangeAccent),
        primaryColor: Colors.white,textTheme: TextTheme(bodyText1: GoogleFonts.roboto(fontSize: 15))),
        home: HomePage(),
      ),
    );

  }
}

