import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/screens/login_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fluttertalk03",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red
      ),
      home: cekLogin(),
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/profile": (context) => ProfileScreen()
      },
    );
  }
}

class cekLogin extends StatefulWidget {
  cekLogin({Key key}) : super(key: key);

  @override
  _cekLoginState createState() => _cekLoginState();
}

class _cekLoginState extends State<cekLogin> {

  @override
  void initState() { 
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final username = pref.getString('username');

    if (username != null) {
      Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.pushNamedAndRemoveUntil(context, "/profile", (Route<dynamic> routes) => false);
      });
    }else{
      Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> routes) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: spashscreen(),
    );
  }

  Widget spashscreen(){
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.red,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.vpn_key, size: 40, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "flutter.id",
                  style: TextStyle(
                    fontSize: 35, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          )
        );
  }
}