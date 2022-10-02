import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/custom/custom_evelated_button_widget.dart';
import 'package:tmay/custom/custom_text_form_field_widget.dart';
import 'package:tmay/services/auth_service.dart';
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
  final AuthService _authService = AuthService();
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
                20, MediaQuery.of(context).size.height * 0.05, 20, 0),
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
                        prefixIconData: FontAwesomeIcons.solidEnvelope,
                        onChange: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        onValidate: (val) {
                          if (val == "") {
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
                        isPasswordField: _obscuredText,
                        labelText: "Enter Password",
                        prefixIconData: FontAwesomeIcons.lock,
                        suffixIconData: _obscuredText == true
                            ? FontAwesomeIcons.solidEyeSlash
                            : FontAwesomeIcons.solidEye,
                        onChange: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        onValidate: (val) {
                          if (val == "") {
                            return "Please enter a password";
                          } else if (val != null && val.length < 6) {
                            return "Please enter password at least 6 char long";
                          }
                          return null;
                        },
                        toggleSuffix: () {
                          setState(() {
                            _obscuredText = !_obscuredText;
                          });
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
                                fontSize: 15.0,
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
                            dynamic result = await _authService
                              .signInWithEmailAndPassword(
                              email, password);
                            if (result.user == null) {
                              showToast("Login failed, Check credentials!", hexStringToColor("#cd2b27"));
                            } else {
                              showToast("Login success", hexStringToColor("#abed5d"));
                            }
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
                              fontSize: 15.0,
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
                            style: TextStyle(
                              color: hexStringToColor("#3a393f"),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          TextButton(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: hexStringToColor("#cd2b27"),
                                fontSize: 15.0,
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
