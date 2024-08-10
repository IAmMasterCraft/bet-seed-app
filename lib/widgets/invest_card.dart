import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/models/investments_model.dart';
import 'package:bet_seed/utils/colors.dart';

import 'tips_card_row.dart';

class InvestmentCard extends StatefulWidget {
  const InvestmentCard({
    Key? key,
    required this.data,
    this.approve,
    this.reject,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final Function()? approve;
  final Function()? reject;
  @override
  State<InvestmentCard> createState() => _InvestmentCardState();
}

class _InvestmentCardState extends State<InvestmentCard> {
  AllRepos _allRepos = AllRepos();

  @override
  Widget build(BuildContext context) {
    var _investment = InvestmentModel.fromJson(widget.data);

    String startDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_investment.startDate) * 1000));

    String endDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_investment.endDate) * 1000));

    String? _hash;
    if (_investment.type != 3) {
      _hash = _investment.hash!.substring(0, 6) +
          "..." +
          _investment.hash!.substring(
              _investment.hash!.length - 4, _investment.hash!.length);
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: double.infinity,
                color: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TipsCardRow(
                  title: 'Package',
                  value: _investment.title,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TipsCardRow(
                      title: 'Email',
                      value: _investment.email,
                    ),
                    TipsCardRow(
                      title: 'Amount',
                      value: "\$ " + _investment.amount,
                    ),
                    TipsCardRow(
                      title: 'Duration',
                      value: '${_investment.duration} Month(s)',
                    ),
                    _investment.status == 2 || _investment.type == 3
                        ? Column(
                            children: [
                              TipsCardRow(
                                title: 'Start',
                                value: startDate,
                              ),
                              TipsCardRow(
                                title: 'End',
                                value: endDate,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    TipsCardRow(
                      title: 'ROI',
                      value: _investment.roi + "%",
                    ),
                    _investment.type == 3
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              TipsCardRow(
                                title: 'Pay Method',
                                value: _investment.payMethod!.toUpperCase(),
                              ),
                              TipsCardRow(
                                title: 'Trxn Hash',
                                widget: Row(
                                  children: [
                                    Text(_hash!),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () => _allRepos.copyFxn(
                                          _investment.hash!, context),
                                      child: Icon(
                                        IconlyLight.paper,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _investment.status == 1
                                  ? TipsCardRow(
                                      title: 'Update Status',
                                      widget: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _accepRejectDeletePop(
                                                value: "Approve",
                                                fxn: widget.approve,
                                              );
                                            },
                                            icon: Icon(
                                              IconlyLight.tickSquare,
                                              color: primaryColor,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _accepRejectDeletePop(
                                                value: "Reject",
                                                fxn: widget.reject,
                                              );
                                            },
                                            icon: Icon(
                                              IconlyLight.closeSquare,
                                              color: redAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _accepRejectDeletePop({String? value, Function()? fxn}) {
    _allRepos.showPopUp(
        context, Text("Are you sure you want to $value this payout?"), [
      CupertinoButton(child: Text("Yes"), onPressed: fxn),
      CupertinoButton(
        child: Text("No"),
        onPressed: () => Navigator.pop(context),
      ),
    ], [
      TextButton(child: Text("Yes"), onPressed: fxn),
      TextButton(
        child: Text("No"),
        onPressed: () => Navigator.pop(context),
      ),
    ]);
  }
}
