import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:bet_seed/utils/config.dart';
import 'package:bet_seed/utils/strings.dart';

import 'call_fxns.dart';

abstract class BaseDatabase {
  //! Tips
  addTips(Map data, BuildContext context);
  wlTips(Map data, BuildContext context);
  deleteTips(Map data, BuildContext context);
  Future<List> getTips(Map data, BuildContext context);
  updateTips(Map data, BuildContext context);

  //! Adverts

  addAds(Map data, BuildContext context);
  deleteAds(Map data, BuildContext context);
  Future<List> getAds(Map data, BuildContext context);
  updateAds(Map data, BuildContext context);

  //! Notifications

  postNotification(Map data, BuildContext context);
  deleteNotification(Map data, BuildContext context);
  Future<List> getNotifications(BuildContext context);
}

class DatabaseRepo implements BaseDatabase {
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
  addTips(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'tips-add.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }

  @override
  deleteTips(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'tips-delete.php'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List> getTips(Map data, BuildContext context) async {
    List _allTips = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'tips-get.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _allTips = body[MESSAGE];
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
    } catch (e) {
      print(e);
    }
    return _allTips;
  }

  @override
  wlTips(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'tips-wl.php'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }

  @override
  updateTips(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'tips-update.php'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }

  @override
  addAds(Map data, BuildContext context) async {
    try {
      String adsImage = data['adsImage'];
      String adsId = data['adsId'];
      data.removeWhere((key, value) => key == 'adsImage');

      http.Response response = await http.post(
        Uri.parse(url + 'ads-add.php'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        bool _val = await _addAdsImage(adsImage, adsId);
        if (_val) {
          _callFunctions.showSnacky('Ads Added', true, context);
        } else {
          _callFunctions.showSnacky('Error Uploading Image', false, context);
        }
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
      _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
    }
  }

  Future<bool> _addAdsImage(String adsImage, adsId) async {
    try {
      final uri = Uri.parse(url + 'ads-image.php');
      var request = http.MultipartRequest('POST', uri);
      String imgName = APP_NAME + '_ADS_' + randomString(8) + '.jpg';

      String base64encodedData =
          base64Encode(utf8.encode('$username:$password'));

      String header = 'Basic ' + base64encodedData;

      request.headers['Authorization'] = header;
      request.fields['adsId'] = adsId;

      var pic = await http.MultipartFile.fromPath(
        'image',
        adsImage,
        filename: imgName,
      );

      request.files.add(pic);
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  deleteAds(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'ads-delete.php'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List> getAds(Map data, BuildContext context) async {
    List _allAds = [];
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'ads-get.php'),
        body: data,
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _allAds = body[MESSAGE];
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
    } catch (e) {
      print(e);
    }
    return _allAds;
  }

  @override
  updateAds(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'ads-update.phpp'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }

  @override
  deleteNotification(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'notifications-delete.php'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List> getNotifications(BuildContext context) async {
    List _allNotifications = [];
    try {
      http.Response response = await http.get(
        Uri.parse(url + 'notifications-get.php'),
        headers: header,
      );

      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _allNotifications = body[MESSAGE];
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
    } catch (e) {
      print(e);
    }
    return _allNotifications;
  }

  @override
  postNotification(Map data, BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url + 'notifications-add.php'),
        body: data,
        headers: header,
      );
      var body = json.decode(response.body);

      if (body[STATUS] == 'success') {
        _callFunctions.showSnacky(body[MESSAGE], true, context);
      } else {
        _callFunctions.showSnacky(DEFAULT_ERROR, false, context);
      }
      return body;
    } catch (e) {
      print(e);
    }
  }
}
