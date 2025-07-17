import 'package:chatgpt/Model/chatgptprovider.dart';
import 'package:chatgpt/View/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Model/routes.dart';
import 'View/login.dart';
import 'View/mainscreen.dart';

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp(
 //   options: DefaultFirebaseOptions.currentPlatform,
 // );
  runApp(ChangeNotifierProvider(create: (BuildContext context) =>chatprovider(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Login(),
      routes: {
        loginroute:(context)=> Login(),
        signinroute:(context)=> Signin(),
        mainscreenroute:(context)=>Chromeai(),
      },
    );
  }
}

