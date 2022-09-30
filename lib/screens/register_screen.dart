import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/custom/custom_evelated_button_widget.dart';
import 'package:tmay/custom/custom_text_form_field_widget.dart';
import 'package:tmay/services/auth_service.dart';
import 'package:tmay/utils/colors_utils.dart';
import 'package:tmay/utils/widget_utils.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  const RegisterScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _obscuredText = true;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  void _showMaterialDialog(message, titleMessage) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(titleMessage),
          content: Text(message),
          actions: <Widget>[
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.circleXmark),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

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
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: CustomTextFormFieldWidget(
                              isPasswordField: false,
                              labelText: "First Name",
                              prefixIconData: FontAwesomeIcons.person,
                              sufixIconData: null,
                              onChange: (val) {
                                setState(() {
                                  firstName = val;
                                });
                              },
                              onValidate: (val) {
                                if (val == "") {
                                  return "Please enter a first name";
                                }
                                return null;
                              },
                              toggleSuffix: null,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomTextFormFieldWidget(
                              isPasswordField: false,
                              labelText: "Last Name",
                              prefixIconData: FontAwesomeIcons.personCirclePlus,
                              sufixIconData: null,
                              onChange: (val) {
                                setState(() {
                                  lastName = val;
                                });
                              },
                              onValidate: (val) {
                                if (val == "") {
                                  return "Please enter a last name";
                                }
                                return null;
                              },
                              toggleSuffix: null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormFieldWidget(
                        isPasswordField: false,
                        labelText: "Enter Email",
                        prefixIconData: FontAwesomeIcons.solidEnvelope,
                        sufixIconData: null,
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
                        toggleSuffix: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormFieldWidget(
                        isPasswordField: _obscuredText,
                        labelText: "Enter Password",
                        prefixIconData: FontAwesomeIcons.lock,
                        sufixIconData: _obscuredText == true
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
                        height: 20,
                      ),
                      CustomTextFormFieldWidget(
                        isPasswordField: _obscuredText,
                        labelText: "Re-Enter Password",
                        prefixIconData: FontAwesomeIcons.lock,
                        onChange: (val) {
                          setState(() {
                            confirmPassword = val;
                          });
                        },
                        onValidate: (val) {
                          if (val == "") {
                            return "Please re-enter a password";
                          } else if (confirmPassword != val) {
                            return "Password does not match";
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
                        height: 20,
                      ),
                      CustomElevatedButtonWidget(
                        labelText: "Register",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            /*dynamic result = await _authService
                              .signInWithEmailAndPassword(
                              email, password);*/
                            dynamic result = await _authService
                                .registerWithEmailAndPassword(
                                email, password, firstName, lastName);
                            if (result.user == null) {
                              showToast("Registration failed", hexStringToColor("#cd2b27"));
                            } else {
                              showToast("Registration complete", hexStringToColor("#abed5d"));
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account ?',
                            style: TextStyle(
                              color: hexStringToColor("#3a393f"),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          TextButton(
                            child: Text(
                              'Login',
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
