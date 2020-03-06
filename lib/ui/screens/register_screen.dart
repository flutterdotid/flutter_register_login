import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/services/auth_services.dart';
import '../../core/utils/toast_utils.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ), child: Scaffold(
        body: SingleChildScrollView(
         child: RegisterBody(),
        ),
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {
  RegisterBody({Key key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {


  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var emailController = TextEditingController();


  void register() async {
    if (usernameController.text.isNotEmpty 
        && passwordController.text.isNotEmpty
        && confirmPasswordController.text.isNotEmpty 
        && emailController.text.isNotEmpty
    ) {

      if (passwordController.text == confirmPasswordController.text) {

        Map<String, dynamic> data = {
          "username": usernameController.text,
          "password": passwordController.text,
          "email": emailController.text
        };

        ToastUtils.show("Registering ...");
        var response = await AuthServices.register(data);
        if (response.status == 201) {
          ToastUtils.show(response.message);
          Navigator.pop(context);
        } else {
          ToastUtils.show(response.message);
        }

      } else {
        ToastUtils.show("Password not match");
      }
    } else {
      ToastUtils.show("Please Input All field");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[


        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/5,
          color: Colors.red,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                    ),
                  ),
                ),

                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 10,), 



              ],
            ),
          ),
        ),

        //Bagian field Register
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: <Widget>[
              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: usernameController,
                hintText: "Username",
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: passwordController,
                hintText: "Password",
                secureText: true,
              ),
              SizedBox(height: 15),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                secureText: true,
              ),
              SizedBox(height: 15),
              
              InputField(
                action: TextInputAction.done,
                type: TextInputType.emailAddress,
                controller: emailController,
                hintText: "Email Address",
              ),
              SizedBox(height: 10),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: PrimaryButton(
                  color: Colors.red,
                  text: "REGISTER",
                  onClick: () => register(),
                ),
              ),
              SizedBox(height: 30),
              
            ],
          ),
        )
        
      ],
    );
  }
}