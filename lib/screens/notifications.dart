import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/utils/strings.dart';
import 'package:bet_seed/widgets/cust_text_field.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/lazy_load_wid.dart';
import 'package:bet_seed/widgets/notification_wid.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  AllRepos _allRepos = AllRepos();
  GlobalKey<FormState> _notificationKey = GlobalKey();

  String? _notificationTitle, _notificationBody;

  Future<List>? _future;
  @override
  void initState() {
    _getNotifications();
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

  Future<List>? _getNotifications() {
    _future = _allRepos.getNotifications(context);
    return _future;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
        isLoading: isLoading,
        title: 'Notifications',
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _createNotificationPop,
          label: Text('Create'),
          icon: Icon(
            IconlyLight.message,
          ),
        ),
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
                    return NotificationWid(
                      data: _datas[index],
                    );
                  },
                );
              }
            }));
  }

  _createNotificationPop() {
    _allRepos.showPopUp(
        context,
        Form(
          key: _notificationKey,
          child: Material(
            color: transparent,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustTextField(
                    hintText: 'Notification Title',
                    validator: _allRepos.validateEmpty,
                    onChanged: (String? val) {
                      setState(() {
                        _notificationTitle = val;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustTextField(
                    hintText: 'Notification Body',
                    maxLines: 4,
                    validator: _allRepos.validateEmpty,
                    onChanged: (String? val) {
                      setState(() {
                        _notificationBody = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        [
          CupertinoButton(child: Text("Send"), onPressed: _postNotiifcation),
          CupertinoButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        [
          TextButton(child: Text("Send"), onPressed: _postNotiifcation),
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        barrierDismissible: false);
  }

  _postNotiifcation() async {
    if (_notificationKey.currentState!.validate()) {
      _notificationKey.currentState!.save();

      String _notificationId = randomString(8);

      Map data = {
        "notificationId": _notificationId,
        "notificationTitle": _notificationTitle,
        "notificationBody": _notificationBody,
        "notificationTopic": 'notification',
      };
      setState(() {
        isLoading = true;
      });
      Navigator.pop(context);

      await _allRepos.postNotification(data, context);
      _refreshFxn();
    }
    setState(() {
      isLoading = false;
    });
  }

  _refreshFxn() {
    setState(() {
      _getNotifications();
    });
  }
}
