import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:bet_seed/screens/home.dart';
import 'package:bet_seed/screens/sign_in.dart';
import 'package:bet_seed/utils/strings.dart';

class AppMiddleWare extends StatelessWidget {
  const AppMiddleWare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userBx = Hive.box(USERS);

    if (userBx.isEmpty) {
      return SignIn();
    } else {
      Map _user = userBx.get('user');
      bool _blocked = _user['blocked'] == 0 ? false : true;
      bool _verified = _user['verified'] == 0 ? false : true;
      bool _admin = _user['admin'] == 0 ? false : true;

      if (!_blocked && _verified && _admin) {
        return MyHomePage();
      } else {
        return SignIn();
      }
    }
  }
}
