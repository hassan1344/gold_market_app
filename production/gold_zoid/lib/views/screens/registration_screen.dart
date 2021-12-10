import 'package:flutter/material.dart';
import 'package:gold_zoid/views/widgets/commonWidgets/login_signup_navigator.dart';
import 'package:gold_zoid/constants.dart';
import 'package:gold_zoid/views/widgets/commonWidgets/custom_text_field.dart';
import 'package:gold_zoid/controllers/validation_logic.dart';
import 'package:provider/provider.dart';
import 'package:gold_zoid/controllers/password_show_controller.dart';

class Registration_Page extends StatefulWidget {
  @override
  _Registration_PageState createState() => _Registration_PageState();
}

class _Registration_PageState extends State<Registration_Page> {

  final _name = TextEditingController();
  final _emailId = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _validate = ValidationLogic();

  @override
  void dispose() {
    _name.dispose();
    _emailId.dispose();
    _password.dispose();
    _confirmPassword.dispose(); 

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Sign ',
                      style: TextStyle(
                        letterSpacing: -1.0,
                        color: kPrimaryColor,
                        fontSize: 45.0,
                        fontFamily: 'Avenir',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'up',
                          style: TextStyle(
                            letterSpacing: -1.0,
                            color: Color(0xFF0000000),
                            fontSize: 45.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                CustomTextField(
                  controller: _name,
                  textAlign: TextAlign.start,
                  validate: _validate.validateName,
                  obscureText: false,
                  maxLength: null,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: kPrimaryColor,
                    size: 30.0,
                  ),
                  hintText: 'Enter your name',
                ),
                SizedBox(
                  height: 30.0,
                ),
                CustomTextField(
                  controller: _emailId,
                  textAlign: TextAlign.start,
                  validate: _validate.validatePhoneNumber,
                  obscureText: false,
                  maxLength: 13,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(
                    Icons.call_outlined,
                    color: kPrimaryColor,
                    size: 30.0,
                  ),
                  hintText: 'Enter your phone number',
                ),
                SizedBox(
                  height: 30.0,
                ),
                Consumer<PasswordShowController>(
                    builder: (context, provider, _) {
                      return CustomTextField(
                        controller: _password,
                        textAlign: TextAlign.start,
                        validate: _validate.validatePassword,
                        maxLength: null,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: kPrimaryColor,
                          size: 30.0,
                        ),
                        suffixIcon: InkWell(
                          onTap: () => provider.changePasswordIcon(),
                          child: Icon(
                            provider.securetext ?
                            Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                            color: kPrimaryColor,
                            size: 30.0,
                          ),
                        ),
                        obscureText: provider.securetext,
                        hintText: 'Enter your password',
                      );
                    },
                  ),
                SizedBox(
                  height: 30.0,
                ),
                Consumer<PasswordShowController>(
                    builder: (context, provider, _) {
                      return CustomTextField(
                        controller: _confirmPassword,
                        textAlign: TextAlign.start,
                        validate: _validate.validatePassword,
                        maxLength: null,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: kPrimaryColor,
                          size: 30.0,
                        ),
                        suffixIcon: InkWell(
                          onTap: () => provider.changePasswordIcon(),
                          child: Icon(
                            provider.securetext ?
                            Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                            color: kPrimaryColor,
                            size: 30.0,
                          ),
                        ),
                        obscureText: provider.securetext,
                        hintText: 'Enter your password',
                      );
                    },
                  ),
                SizedBox(
                  height: 40.0,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if(_name == null && _emailId == null && _password == null && _confirmPassword == null && _password!=_confirmPassword ) 
                      print("enter fields correctly");

                      // autenticate user and navigate to homePAge..
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: kSecondaryTextColor,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      height: 55.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2.0,
                            color: kPrimaryColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: LoginSignUpNavigator(
                      text1: 'Already have an account?',
                      text2: 'Login here',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
