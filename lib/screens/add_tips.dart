import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/utils/decimals.dart';
import 'package:bet_seed/utils/strings.dart';
import 'package:bet_seed/widgets/cust_button.dart';
import 'package:bet_seed/widgets/cust_text_field.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';

class AddTips extends StatefulWidget {
  const AddTips({
    Key? key,
    this.isFree = true,
  }) : super(key: key);

  final bool isFree;
  @override
  _AddTipsState createState() => _AddTipsState();
}

class _AddTipsState extends State<AddTips> {
  AllRepos _allRepos = AllRepos();
  GlobalKey<FormState> _tipsKey = GlobalKey();

  String _sports = 'Football';
  bool? _sendNotification = false;

  DateTime _selectedDateTime = DateTime.now();
  String? _league, _teamOne, _teamTwo, _tips, _odds, _probability, _amount;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String title = widget.isFree ? "Free" : "Premium";

    String _selectedDateString =
        DateFormat("kk:mm - dd/MM/yyyy").format(_selectedDateTime);
    return CustonScaffold(
      isLoading: isLoading,
      title: 'Add $title Tips',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _tipsKey,
            child: Column(
              children: [
                ListTile(
                  title: Text('Sports'),
                  trailing: InkWell(
                    onTap: () => _allRepos.showPicker(
                      context,
                      children: SPORTS_LIST,
                      onChanged: (String? val) {
                        setState(() {
                          _sports = val!;
                        });
                      },
                      onSelectedItemChanged: (int? val) {
                        setState(() {
                          _sports = SPORTS_LIST[val!];
                        });
                      },
                    ),
                    child: Container(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              _sports,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 5),
                          Flexible(
                            child: Icon(IconlyLight.arrowDown2, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Time - Date"),
                  trailing: InkWell(
                      onTap: () => datePicker(),
                      child: Text(_selectedDateString)),
                ),
                CustTextField(
                  labelText: 'League',
                  hintText: 'England: Premiere League',
                  validator: _allRepos.validateEmpty,
                  onChanged: (String? val) {
                    setState(() {
                      _league = val;
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: CustTextField(
                        labelText: 'Team One',
                        hintText: 'Manchester City',
                        validator: _allRepos.validateEmpty,
                        onChanged: (String? val) {
                          setState(() {
                            _teamOne = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: CustTextField(
                        labelText: 'Team Two',
                        hintText: 'Watford',
                        validator: _allRepos.validateEmpty,
                        onChanged: (String? val) {
                          setState(() {
                            _teamTwo = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustTextField(
                  labelText: 'Tips',
                  hintText: 'Over 2.5 goals',
                  validator: _allRepos.validateEmpty,
                  onChanged: (String? val) {
                    setState(() {
                      _tips = val;
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    widget.isFree
                        ? SizedBox.shrink()
                        : Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: CustTextField(
                                    labelText: 'Amount',
                                    hintText: '1000 Coins',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validator: _allRepos.validateEmpty,
                                    onChanged: (String? val) {
                                      setState(() {
                                        _amount = val;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                    Flexible(
                      child: CustTextField(
                        labelText: 'Odds',
                        hintText: '1.56',
                        inputFormatters: [DecimalTextInputFormatter()],
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: _allRepos.validateEmpty,
                        onChanged: (String? val) {
                          setState(() {
                            _odds = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: CustTextField(
                        labelText: 'Probability',
                        hintText: '92.1%',
                        inputFormatters: [DecimalTextInputFormatter()],
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: _allRepos.validateEmpty,
                        onChanged: (String? val) {
                          setState(() {
                            _probability = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                CheckboxListTile(
                  title: Text('Send Notification'),
                  value: _sendNotification,
                  onChanged: (newValue) {
                    setState(() {
                      _sendNotification = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                CustomButton(
                  onTap: () => _addTipsFxn(),
                  title: 'Add Tips',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  datePicker() async {
    DateTime _dateTime = DateTime.now();
    DateTime _maximumDate = _dateTime.add(Duration(days: 14));
    DateTime _minimumDate = _dateTime;

    if (Platform.isAndroid) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                use24hFormat: true,
                onDateTimeChanged: (DateTime dt) {
                  setState(() {
                    _selectedDateTime = dt;
                  });
                },
                maximumDate: _maximumDate,
                minimumDate: _minimumDate,
                initialDateTime: _selectedDateTime,
                minimumYear: _minimumDate.year,
                maximumYear: _dateTime.year,
              ),
            );
          });
    } else {
      await DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: _minimumDate,
        maxTime: _maximumDate,
        onChanged: (date) {
          setState(
            () {
              _selectedDateTime = date;
            },
          );
        },
        onConfirm: (date) {
          setState(() {
            _selectedDateTime = date;
          });
        },
        currentTime: _selectedDateTime,
      );
    }
  }

  _addTipsFxn() async {
    try {
      if (_tipsKey.currentState!.validate()) {
        _tipsKey.currentState!.save();

        String _freePaid = widget.isFree ? "freeTips" : "paidTips";
        String _sportId = randomString(8);

        String _date = DateFormat("dd-MM-yyyy").format(_selectedDateTime);
        String _time = DateFormat("kk:mm").format(_selectedDateTime);
        Map data = {
          'freePaid': _freePaid,
          'sportId': _sportId,
          'sportType': _sports,
          'league': _league,
          'teamOne': _teamOne,
          'teamTwo': _teamTwo,
          'tips': _tips,
          'odds': _odds,
          'amount': _amount ?? '0',
          'sportDate': _date,
          'sportTime': _time,
          'probability': _probability,
        };

        setState(() {
          isLoading = true;
        });

        await _allRepos.addTips(data, context);
        if (_sendNotification!) {
          String _tipsType = widget.isFree ? "Free" : "Premium";

          String _notificationBody = "$_league -  $_teamOne vs $_teamTwo";
          Map data = {
            "notificationId": _sportId,
            "notificationTitle": 'New $_tipsType Tips',
            "notificationBody": _notificationBody,
            "notificationTopic": 'tips',
          };
          await _allRepos.postNotification(data, context);
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }
}
