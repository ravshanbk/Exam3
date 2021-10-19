// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:imtihon3/Pages/gamingpage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _parolController = TextEditingController();
  final String _login = "admin";
  final String _parol = "1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 300.0,right: 40.0,left: 40.0,top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _getLoginField(),
              _getParolField(),
             
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamingPage(),
                      ),
                    );
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 22.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getLoginField() {
    return TextFormField(
      validator: (v) {
        if (v != _login) {
          return "Notog'ri Login";
        }
      },
      controller: _loginController,
      style: TextStyle(fontSize: 22.0),
      decoration: InputDecoration(
        label: Text("admin"),

        hintText: "Login . . .",
        hintStyle: TextStyle(fontSize: 22.0),
        prefixIcon: Icon(Icons.edit),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  _getParolField() {
    return TextFormField(
      validator: (v) {
        if (v != _parol) {
          return "Notog'ri parol";
        }
      },
      controller: _parolController,
      style: TextStyle(fontSize: 22.0),
      decoration: InputDecoration(
        label: Text("1234"),
        hintText: "Parol . . .",
        hintStyle: TextStyle(fontSize: 22.0),
        prefixIcon: Icon(Icons.edit),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
