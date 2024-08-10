import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';
import 'package:bet_seed/widgets/tips_card.dart';

class PastTips extends StatefulWidget {
  const PastTips({Key? key}) : super(key: key);

  @override
  _PastTipsState createState() => _PastTipsState();
}

class _PastTipsState extends State<PastTips>
    with SingleTickerProviderStateMixin {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;

  TabController? _tabController;
  DateTime _selectedDateTime = DateTime.now().subtract(Duration(days: 1));

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _getTips();

    super.initState();
  }

  _getTips() {
    String _freePaid = _tabController!.index == 0 ? 'freeTips' : 'paidTips';
    String _date = DateFormat("dd-MM-yyyy").format(_selectedDateTime);

    Map data = {
      'freePaid': _freePaid,
      'sportDate': _date,
    };
    _future = _allRepos.getTips(data, context);
  }

  @override
  Widget build(BuildContext context) {
    String _selectedDateString =
        DateFormat("dd-MM-yyyy").format(_selectedDateTime);

    return CustonScaffold(
      title: 'Past Tips',
      centerTitle: false,
      selectedDate: _selectedDateString,
      hasDate: false,
      actionIcon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            InkWell(
              onTap: () => addSubDate(false),
              child: Icon(IconlyLight.arrowLeft2),
            ),
            InkWell(
              onTap: () => datePicker(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(IconlyLight.calendar),
                    SizedBox(width: 10),
                    Text(_selectedDateString),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => addSubDate(true),
              child: Icon(IconlyLight.arrowRight2),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ProgIndicator();
            } else {
              List? data = snapshot.data;

              return Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).textTheme.bodyLarge!.color,
                    unselectedLabelColor:
                        Theme.of(context).textTheme.bodyLarge!.color,
                    onTap: (int index) {
                      setState(() {
                        _getTips();
                      });
                    },
                    tabs: [
                      Tab(
                        text: 'Free',
                      ),
                      Tab(text: 'Premium'),
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (context, int index) {
                              data[index]['freePaid'] = 0;
                              data[index]['refreshFxn'] = () {
                                setState(() {
                                  _getTips();
                                });
                              };
                              return TipsCard(data: data[index]);
                            }),
                        ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, int index) {
                              data[index]['freePaid'] = 1;
                              data[index]['refreshFxn'] = () {
                                setState(() {
                                  _getTips();
                                });
                              };
                              return TipsCard(data: data[index]);
                            }),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  addSubDate(bool _isAdd) {
    DateTime _dateTime = DateTime.now();
    DateTime _add = _selectedDateTime.add(Duration(days: 1));
    DateTime _sub = _selectedDateTime.subtract(Duration(days: 1));
    if (_isAdd) {
      if (_add.difference(_dateTime).inDays < 0) {
        setState(() {
          _selectedDateTime = _add;
          _getTips();
        });
      }
    } else {
      if (_sub.difference(_dateTime).inDays.abs() <= 30) {
        setState(() {
          _selectedDateTime = _sub;

          _getTips();
        });
      }
    }
  }

  datePicker() async {
    DateTime _dateTime = DateTime.now();
    DateTime _maximumDate = _dateTime.subtract(Duration(days: 1));
    DateTime _minimumDate = _dateTime.subtract(Duration(days: 31));

    if (Platform.isIOS) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime dt) {
                  setState(() {
                    _selectedDateTime = dt.add(Duration(days: 1));
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
      DateTime? dt = await showDatePicker(
        context: context,
        initialDate: _selectedDateTime,
        firstDate: _minimumDate,
        lastDate: _maximumDate,
        initialDatePickerMode: DatePickerMode.year,
      );

      setState(() {
        _selectedDateTime = dt!.add(Duration(days: 1));
      });
    }
  }
}
