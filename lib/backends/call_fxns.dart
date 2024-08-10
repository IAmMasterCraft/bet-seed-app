import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bet_seed/utils/colors.dart';

abstract class BaseCallFunctions {
  showSnacky(String msg, bool isSuccess, BuildContext context,
      {Map<String, String>? args, String extra2});

  showPicker(
    BuildContext context, {
    List<dynamic>? children,
    Function(int?)? onSelectedItemChanged,
    Function(String?)? onChanged,
    bool hasTrns = true,
  });

  showModalBar(
    BuildContext context,
    Widget content, {
    bool isDismissible,
  });

  showModalBarAction(
    BuildContext context,
    Widget child,
    List<Widget> action,
  );

  showPopUp(
    BuildContext context,
    Widget content,
    List<CupertinoButton> iosActions,
    List<TextButton> androidActions, {
    IconData icon,
    String msg,
    Color color,
    bool barrierDismissible = true,
  });

  copyFxn(String text, BuildContext context);
}

class CallFunctions implements BaseCallFunctions {
  @override
  showSnacky(String msg, bool isSuccess, BuildContext context,
      {Map<String, String>? args, String extra2 = ""}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isSuccess ? primaryColor : red,
    ));
  }

  @override
  showPicker(BuildContext context,
      {List<dynamic>? children,
      Function(int?)? onSelectedItemChanged,
      Function(String?)? onChanged,
      bool hasTrns = true}) {
    Platform.isIOS
        ? showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.3,
                  onSelectedItemChanged: onSelectedItemChanged,
                  itemExtent: 32.0,
                  children: children!.map((value) {
                    return hasTrns
                        ? Text(
                            value!,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          )
                        : Text(
                            value.toUpperCase(),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          );
                  }).toList(),
                ),
              );
            })
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 200,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: Icon(IconlyLight.arrowDown2),
                    // iconEnabledColor: Theme.of(context).primaryColor,
                    underline: Container(),
                    hint: Text('Select'),
                    items: children!.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: hasTrns
                            ? Text(value!)
                            : Text(
                                value.toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          );
  }

  @override
  showPopUp(
    BuildContext context,
    Widget content,
    List<CupertinoButton> iosActions,
    List<TextButton> androidActions, {
    String? msg,
    IconData? icon,
    Color? color,
    bool barrierDismissible = true,
  }) {
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: barrierDismissible,
            context: context,
            builder: (_) => CupertinoAlertDialog(
              content: content,
              title: icon != null
                  ? Icon(
                      icon,
                      color: color,
                      size: 30,
                    )
                  : msg != null
                      ? Text(
                          msg,
                          style: TextStyle(color: color),
                        )
                      : null,
              actions: iosActions,
            ),
          )
        : showDialog(
            barrierDismissible: barrierDismissible,
            context: context,
            builder: (_) => AlertDialog(
              content: content,
              title: icon != null
                  ? Icon(
                      icon,
                      color: color,
                      size: 30,
                    )
                  : msg != null
                      ? Text(
                          msg,
                          style: TextStyle(color: color),
                        )
                      : null,
              actions: androidActions,
            ),
          );
  }

  @override
  showModalBarAction(
    BuildContext context,
    Widget child,
    List<Widget> action,
  ) {
    Platform.isIOS
        ? showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              actions: action,
              cancelButton: CupertinoActionSheetAction(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        : showModalBottomSheet(context: context, builder: (_) => child);
  }

  @override
  showModalBar(
    BuildContext context,
    Widget content, {
    bool? isDismissible,
  }) {
    Platform.isIOS
        ? showCupertinoModalBottomSheet(
            isDismissible: isDismissible ?? true,
            context: context,
            builder: (_) => Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: content,
            ),
          )
        : showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: isDismissible ?? true,
            context: context,
            builder: (_) => Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: content,
            ),
          );
  }

  @override
  copyFxn(String text, BuildContext context) {
    FlutterClipboard.copy(text).then(
      (value) => showSnacky("$text Copied", true, context),
    );
  }
}
