import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  double _opacityValue = 0.9;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [hexStringToColor("#FFFDE4"), hexStringToColor("#005AA7")],
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
                logoWidget("assets/images/app_logo_tmay.png"),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Colors.white24,
                            ),
                            labelText: "Enter Email",
                            labelStyle: TextStyle(
                              color: Colors.white24,
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            //fillColor: new Colors().white.,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(width: 0, style: BorderStyle.none),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
