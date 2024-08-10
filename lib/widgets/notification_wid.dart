import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/models/notifications_model.dart';
import 'package:bet_seed/utils/colors.dart';

class NotificationWid extends StatefulWidget {
  const NotificationWid({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _NotificationWidState createState() => _NotificationWidState();
}

class _NotificationWidState extends State<NotificationWid> {
  AllRepos _allRepos = AllRepos();

  @override
  Widget build(BuildContext context) {
    var _notifications = NotificationsModel.fromJson(widget.data);
    return Column(
      children: [
        ListTile(
          title: Text(_notifications.notificationTitle),
          subtitle: Text(
            _notifications.notificationBody,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () => _deletePop(_notifications),
            icon: Icon(
              IconlyLight.delete,
              color: red,
            ),
          ),
        ),
        Divider(
          color: primaryColor,
          indent: 8.0,
        ),
      ],
    );
  }

  _deletePop(NotificationsModel _notifications) {
    _allRepos.showPopUp(
        context, Text("Are you sure you want to delete notification?"), [
      CupertinoButton(
        child: Text("Delete"),
        onPressed: () => _deleteNotification(_notifications),
      ),
      CupertinoButton(
        child: Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
    ], [
      TextButton(
        child: Text("Delete"),
        onPressed: () => _deleteNotification(_notifications),
      ),
      TextButton(
        child: Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
    ]);
  }

  _deleteNotification(NotificationsModel _notifications) async {
    Map data = {
      'notificationId': _notifications.notificationId,
    };
    await _allRepos.deleteNotification(data, context);
    _notifications.refreshFxn!();
    Navigator.pop(context);
  }
}
