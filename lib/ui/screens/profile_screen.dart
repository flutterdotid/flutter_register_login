import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/primary_button.dart';
import '../../core/utils/toast_utils.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: ProfileBody()
        ),
      ),
    );
  }
}


class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {


  String username, email, pathPhoto;


  @override
  void initState() { 
    super.initState();
    getPref();
  }

  logout(){
    ToastUtils.show("Logout ...");
    savePref();
    Future.delayed(const Duration(milliseconds: 2000), () {
        ToastUtils.show("Logout Success");
        Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> routes) => false);
    });
  }

  savePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.remove('username');
      pref.remove('email');
    });
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
     username = pref.getString('username');
     email = pref.getString('email'); 
    });

    if (username != null) {
    }else{
        Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> routes) => false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4,
          color: Colors.red,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                Text(
                  username.toString(),
                  style: TextStyle(
                    fontSize: 25, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    email.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15, 
                      color: Colors.white, 
                    ),
                  ),
                )
              ],
            ),
          )
        ),

        //Bagian field login
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          email.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: PrimaryButton(
                  color: Colors.red,
                  text: "LOGOUT",
                  onClick: (){
                    logout();
                  },
                ),
              )

      ],
    );
  }
}
