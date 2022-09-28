import 'package:calculator_app/screens/home_screen/home_screen.dart';
import 'package:calculator_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  //providerscope:Sağlayıcıların durumunu depolayan bir pencere öğesi.
//Riverpod kullanan tüm Flutter uygulamaları , widget ağacının kökünde bir ProviderScope içermelidir 
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Montserrat',
                bodyColor: kSecondaryColor,
              )),
      home: const HomeScreen(),
    );
  }
}
