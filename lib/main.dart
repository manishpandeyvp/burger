import 'package:burger/first_screen.dart';
import 'package:burger/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_in.dart';

void main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //TODO: Create Org Login Landing Page or Org Home
//TODO: Fix Landing Screen Problem
  final Widget home;

  MyApp({this.home});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Consumer(
          // ignore: missing_return
          builder: (context, UserRepository user, _) {
            switch (user.status) {
              case Status.Uninitialized:
                return LoginPage();
              case Status.Unauthenticated:
                return LoginPage();
              case Status.Authenticating:
                return Scaffold(
                  body: LoginPage(),
                );
              case Status.Authenticated:
                {
                  return FirstScreen();
                }
              default:
                //return HomePage();
                return LoginPage();
            }
          },
        ),
      ),
    );
  }
}
