// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imtihon3/Models/modelphrase.dart';
import 'package:imtihon3/Pages/loginpage.dart';

class GamingPage extends StatefulWidget {
  const GamingPage({Key? key}) : super(key: key);
  final int chance = 3;

  @override
  _GamingPageState createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> {
  final TextEditingController _inputController = TextEditingController();
  String? _givenText;
  final String _url = "https://geek-jokes.sameerkumar.website/api?format=json";
  Phrase? phrase;
  DateTime _now = DateTime.now();
  int? _givenTime;
  int _succeses = 0;
  int _failure = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(.3), width: 12.0)),
                  height: _size.height * .3,
                  width: _size.width,
                  child: (_failure + _succeses < widget.chance)
                      ? FutureBuilder(
                          future: _getData(),
                          builder: (context, AsyncSnapshot<Phrase> snap) {
                            var data = snap.data;
                            return snap.hasData
                                ? Text(
                                    data!.joke.toString(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 24.0,
                                    ),
                                  )
                                : Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 50.0,
                                    ),
                                  );
                          },
                        )
                      : _noChanseWidget()),
              _inpuField(),
              _underInputFieldWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Phrase> _getData() async {
    try {
      var res = await http.get(Uri.parse(_url));
      var decodedJson = json.decode(res.body);
      phrase = Phrase.fromJson(decodedJson);
      _givenTime = phrase!.joke.toString().length.toInt() * 2;
      _givenText = phrase!.joke.toString();

      return phrase!;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error");
    }
  }

  _showSnackBar(String _textFrom) {
    return SnackBar(
      backgroundColor: const Color(0xff1eab62),
      margin: const EdgeInsets.only(
          bottom: 440.0, right: 20.0, left: 20.0, top: 69),
      behavior: SnackBarBehavior.floating,
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              style: TextStyle(
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
                fontSize: 26.0,
              ),
              text: _textFrom,
            ),
          ],
        ),
      ),
    );
  }

  _underInputFieldWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.check,
          size: 33.0,
        ),
        Text(
          " ${_succeses.toString()}",
          style: TextStyle(fontSize: 24.0, color: Colors.red),
        ),
        _enterButton(),
        Icon(
          Icons.cancel_outlined,
          size: 33.0,
        ),
        Text(
          " ${_failure.toString()}",
          style: TextStyle(fontSize: 24.0, color: Colors.red),
        ),
      ],
    );
  }

  _enterButton() {
    return ElevatedButton(
      onPressed: () {
        {
          int duration =
              (((DateTime.now().second.toInt()) - _now.second.toInt()) > 0
                  ? ((DateTime.now().second.toInt()) - _now.second.toInt())
                  : ((_now.second.toInt() - 60) +
                      (DateTime.now().second.toInt())));
          debugPrint("\nDuration $duration\n");

          if (_inputController.text.toLowerCase() ==
                  _givenText!.toLowerCase() &&
              (duration < _givenTime!)) {
            ScaffoldMessenger.of(context)
                .showSnackBar(_showSnackBar("Muvaffaqiyat !!!"));
            _inputController.clear();
            _succeses++;
            setState(() {
              _now = DateTime.now();
            });
            debugPrint("\nMATCHED\n");
          } else if (_inputController.text.toLowerCase() ==
                  _givenText!.toLowerCase() &&
              duration > _givenTime!) {
            ScaffoldMessenger.of(context)
                .showSnackBar(_showSnackBar("Ulgurmadingiz"));
            _inputController.clear();
            _failure++;
            setState(() {
              _now = DateTime.now();
            });

            debugPrint(duration.toString());
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(_showSnackBar("Mag'lubiyat"));
            _failure++;
            setState(
              () {
                _now = DateTime.now();
                _inputController.clear();
              },
            );
          }
        }
      },
      child: Text(
        "ENTER",
        style: TextStyle(fontSize: 33.0),
      ),
    );
  }

  _noChanseWidget() {
    return Center(
      child: Column(
        children: [
          Text("Imkoniyatlaringiz tugadi"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("Retry"),
          )
        ],
      ),
    );
  }

  _inpuField() {
    return TextFormField(
      decoration: InputDecoration(),
      style: TextStyle(fontSize: 28.0),
      maxLines: 5,
      controller: _inputController,
      onChanged: (v) {
        if (v == _givenText) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_showSnackBar("Muvaffaqiyat !!!"));
          _inputController.clear();
          _succeses++;
          _inputController.clear();
          setState(() {});
        } else if (_givenText!.length == v.length) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_showSnackBar("Mag'lubiyat"));
          _inputController.clear();
          _failure++;
          _inputController.clear();
          setState(() {});
        }
      },
    );
  }
}
