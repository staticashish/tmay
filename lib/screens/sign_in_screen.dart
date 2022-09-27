import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/screens/custom/custom_evelated_button_widget.dart';
import 'package:tmay/screens/custom/custom_text_form_field_widget.dart';
import 'package:tmay/utils/colors_utils.dart';
import 'package:tmay/utils/widget_utils.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  const SignInScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscuredText = true;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#fefefe"),
              hexStringToColor("#fefefe"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.025, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/app_logo_tmay_mint.png"),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextFormFieldWidget(
                        isPasswordField: false,
                        labelText: "Enter Email",
                        prefixIconData: Icons.email_outlined,
                        sufixIconData: null,
                        onChange: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        onValidate: (val) {
                          if (val == null) {
                            return "Please enter an email";
                          } else if (!EmailValidator.validate(val!)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormFieldWidget(
                        isPasswordField: true,
                        labelText: "Enter Password",
                        prefixIconData: Icons.lock_outline_rounded,
                        sufixIconData: null,
                        onChange: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        onValidate: (val) {
                          if (val == null) {
                            return "Please enter a password";
                          } else if (val.length < 6) {
                            return "Please enter password at least 6 char long";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: hexStringToColor("#cd2b27"),
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            onPressed: () => {
                              /*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignInNew()))*/
                              /*_showButtonPressDialog(
                                  context, 'Forgot Password')*/
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomElevatedButtonWidget(
                        labelText: "Login",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            /*dynamic result = await _authService
                              .signInWithEmailAndPassword(
                              email, password);*/
                            print("email => $email password =>$password");
                            /*if (result.user == null) {
                            print("==> " + result.error);
                          }*/
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)),
                            ),
                          ),
                          Text(
                            "OR CONNECT WITH",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: hexStringToColor("#3a393f"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              print("Google pressed");
                            },
                            iconSize: 30.0,
                            icon: FaIcon(FontAwesomeIcons.googlePlusG),
                            color: hexStringToColor("#db4a39"),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          IconButton(
                            onPressed: () {
                              print("facebook pressed");
                            },
                            iconSize: 30.0,
                            icon: FaIcon(
                              FontAwesomeIcons.facebook,
                              color: hexStringToColor("#3b5998"),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          IconButton(
                            onPressed: () {
                              print("linkedin pressed");
                            },
                            iconSize: 30.0,
                            icon: FaIcon(
                              FontAwesomeIcons.linkedin,
                              color: hexStringToColor("#0072b1"),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           Text(
                            'Don\'t have an account ?',
                            style: TextStyle(color: hexStringToColor("#3a393f"),
                                fontSize: 13, fontWeight: FontWeight.w600,),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          TextButton(
                            child:  Text(
                              'Register',
                              style: TextStyle(
                                color: hexStringToColor("#cd2b27"),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
