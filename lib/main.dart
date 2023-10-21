import 'package:expenses_app/widgets/MyMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bottomNavigation.dart';
var KColorScheme = ColorScheme.fromSeed(seedColor: MyMethods.MainColor);


void main() {
WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
   [
     DeviceOrientation.portraitUp,
   ]
  ).then((value) => runApp(MyApp()));
    // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(



      debugShowCheckedModeBanner: false,

      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: MyMethods.MainColor),
        appBarTheme: AppBarTheme().copyWith(color: Colors.white),
        cardTheme: CardTheme().copyWith(
          color: Colors.white,
          elevation: 1.2,
          margin: EdgeInsets.only(top: 2, right: 4, left: 4),
        ),
        listTileTheme: ListTileThemeData().copyWith(
          selectedColor: Colors.white,
        ),
        // scaffoldBackgroundColor: Color.fromARGB(255, 239, 235, 245),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white,
          actionTextColor: MyMethods.MainColor,
          contentTextStyle: TextStyle(color: MyMethods.MainColor),
        ),
      ),

      home: BottomNaviBar(),

    );
  }
}
