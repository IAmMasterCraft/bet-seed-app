import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:bet_seed/utils/strings.dart';

import 'call_fxns.dart';

abstract class BaseDatabase2 {
  //?
  Future<List> getUsers();
  Future<List> getHistory(Map data);
  Future<List> getPayouts(Map data);
  Future<List> getInterests();
  Future<List> getPackages(Map data);
  Future<List> getInvestHistory(Map data);
  Future<List> getRunningInvestments();

  //?

  Future<bool> adminBlock(Map data, context);
  Future<bool> createPackage(Map data, context);
  Future<bool> updatePackage(Map data, context);
  Future<bool> deletePackage(Map data, context);
  Future<bool> approveRejectPayout(Map data, context);
  Future<bool> approveRejectInvestment(Map data, context);
}

class DatabaseRepo2 implements BaseDatabase2 {
  CallFunctions _callFunctions = CallFunctions();

  String url = dotenv.env['ENDPOINT_URL']!;
  static String username = dotenv.env['ENDPOINT_USERNAME']!;
  static String password = dotenv.env['ENDPOINT_PASSWORD']!;
  static String base64encodedData =
      base64Encode(utf8.encode('$username:$password'));

  Map<String, String> header = {
    'Authorization': 'Basic ' + base64encodedData,
  };

  @override
  Future<bool> adminBlock(Map data, context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'user-update.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      print(body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
        return true;
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> createPackage(Map data, context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'package-create.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
        return true;
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> updatePackage(Map data, context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'package-update.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
        return true;
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deletePackage(Map data, context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'package-delete.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
        return true;
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> approveRejectPayout(Map data, context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'payouts-approve-reject.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
        return true;
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List> getUsers() async {
    List _users = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'users-get.php'),
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _users = body[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
    return _users;
  }

  @override
  Future<List> getPackages(Map data) async {
    List _packages = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'package-get.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _packages = body[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
    return _packages;
  }

  @override
  Future<List> getHistory(Map data) async {
    List _allhistory = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'package-history-all.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _allhistory = body[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
    return _allhistory;
  }

  @override
  Future<List> getPayouts(Map data) async {
    List _allPayouts = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'payouts-get.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _allPayouts = body[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
    return _allPayouts;
  }

  @override
  Future<List> getInterests() async {
    List _allInterests = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'interest-get-all.php'),
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _allInterests = body[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
    return _allInterests;
  }

  @override
  Future<bool> approveRejectInvestment(Map data, context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'investment-approve-reject.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
        return true;
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List> getInvestHistory(Map data) async {
    List _investHistory = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'package-investment-get.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _investHistory = body[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
    return _investHistory;
  }

  @override
  Future<List> getRunningInvestments() async {
    List _runningInvestment = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'investment-get.php'),
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _runningInvestment = body[MESSAGE];
      }
    } catch (e) {
      print(e);
    }
    return _runningInvestment;
  }
}
