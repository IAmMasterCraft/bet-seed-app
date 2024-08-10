import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bet_seed/utils/strings.dart';
import 'package:http/http.dart' as http;

import 'call_fxns.dart';

abstract class BaseAdminDB {
  Future<bool> signIn(Map data, BuildContext context);
  Future<Map<String, dynamic>> getUser(Map data);
  Future<bool> logOut(context);
}

class AdminDB implements BaseAdminDB {
  CallFunctions _callFunctions = CallFunctions();

  var userBx = Hive.box(USERS);

  String url = dotenv.env['ENDPOINT_URL']!;
  static String username = dotenv.env['ENDPOINT_USERNAME']!;
  static String password = dotenv.env['ENDPOINT_PASSWORD']!;
  static String base64encodedData =
      base64Encode(utf8.encode('$username:$password'));

  Map<String, String> header = {
    'Authorization': 'Basic ' + base64encodedData,
  };

  @override
  Future<Map<String, dynamic>> getUser(Map data) async {
    Map<String, dynamic> _userData = {};
    try {
      print(data);
      http.Response response = await http.post(
        Uri.parse(url + 'user-get.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _userData = body[MESSAGE];

        userBx.put('user', _userData);
      }
    } catch (e) {
      print(e);
    }
    return _userData;
  }

  @override
  Future<bool> signIn(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'sign-in.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);

        Map _dat = {
          'email': data['email'],
        };
        getUser(_dat);

        return true;
      } else {
        _callFunctions.showSnacky(body[MESSAGE], false, context);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> logOut(context) async {
    try {
      await userBx.clear();
      return true;
    } catch (e) {
      print(e);
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      return false;
    }
  }
}
