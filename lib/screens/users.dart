import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/lazy_load_wid.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;
  @override
  void initState() {
    _getUsers();
    _loadMore(true);
    super.initState();
  }

  bool _loading = false;
  List<int> lData = [];
  int currentLength = 0;

  final int increment = 10;

  Future _loadMore(bool isInit) async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(Duration(seconds: isInit ? 0 : 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      lData.add(i);
    }
    setState(() {
      _loading = false;
      currentLength = lData.length;
    });
  }

  Future<List>? _getUsers() {
    _future = _allRepos.getUsers();
    return _future;
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      isLoading: _loading,
      title: 'Users',
      body: FutureBuilder<List>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ProgIndicator();
            } else {
              List? _datas = snapshot.data;

              return LazyLoadWid(
                isLoading: _loading,
                data: _datas!,
                lData: lData,
                onEndOfPage: () => _loadMore(false),
                itemBuilder: (context, int index) {
                  return UsersWid(
                    data: _datas[index],
                    block: () => popFxn(
                      message: (_datas[index]['blocked'] == 0
                              ? 'block'
                              : 'unblock') +
                          ' this user',
                      fxn: () => adminBlockFxn('blocked', _datas[index]),
                    ),
                    admin: () => popFxn(
                      message:
                          (_datas[index]['admin'] == 0 ? 'make' : 'unmake') +
                              ' this user an admin',
                      fxn: () => adminBlockFxn('admin', _datas[index]),
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  popFxn({String? message, Function? fxn}) {
    _allRepos.showPopUp(context, Text("Are you sure you want to $message ?"), [
      CupertinoButton(child: Text("Yes"), onPressed: () => fxn!()),
      CupertinoButton(
        child: Text(
          "No",
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ], [
      TextButton(child: Text("Yes"), onPressed: () => fxn!()),
      TextButton(
        child: Text(
          "No",
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ]);
  }

  adminBlockFxn(String type, Map data) async {
    try {
      setState(() {
        _loading = true;
      });

      Map _data = {
        'email': data['email'],
        'value': data[type] == 0 ? '1' : '0',
        'adminBlock': type,
      };
      // print(_data);
      await _allRepos.adminBlock(_data, context);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
    setState(() {
      _getUsers();

      _loading = false;
    });
  }
}

class UsersWid extends StatelessWidget {
  const UsersWid({
    Key? key,
    required this.data,
    required this.admin,
    required this.block,
  }) : super(key: key);
  final Map data;
  final Function() admin;
  final Function() block;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data['fullName']),
      subtitle: Text("ID: " + data['uid'].hashCode.toString()),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: block,
              icon: Icon(
                data['blocked'] == 1
                    ? IconlyBold.danger
                    : IconlyLight.dangerTriangle,
                color: red,
              ),
            ),
            IconButton(
              onPressed: admin,
              icon: Icon(
                data['admin'] == 1 ? IconlyBold.star : IconlyLight.star,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
