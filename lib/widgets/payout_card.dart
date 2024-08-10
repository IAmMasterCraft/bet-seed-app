import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/backends/all_repos.dart';

import 'package:bet_seed/models/payouts_model.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'icon_wid.dart';
import 'tips_card_row.dart';

class PayoutsCard extends StatefulWidget {
  const PayoutsCard({
    Key? key,
    required this.data,
    this.approve,
    this.reject,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final Function()? approve;
  final Function()? reject;

  @override
  _PayoutsCardState createState() => _PayoutsCardState();
}

class _PayoutsCardState extends State<PayoutsCard> {
  AllRepos _allRepos = AllRepos();

  @override
  Widget build(BuildContext context) {
    var _payoutModel = PayoutModel.fromJson(widget.data);

    String _createdDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_payoutModel.createdDate)));

    String _updatedDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_payoutModel.updatedDate)));

    String _address = _payoutModel.address.substring(0, 6) +
        "..." +
        _payoutModel.address.substring(
            _payoutModel.address.length - 4, _payoutModel.address.length);
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TipsCardRow(
                  title: 'Payment Method',
                  value: _payoutModel.paymentMethod,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TipsCardRow(
                      title: 'Name',
                      value: _payoutModel.fullName,
                    ),
                    TipsCardRow(
                      title: 'Amount',
                      value: "\$ " + _payoutModel.amount,
                    ),
                    TipsCardRow(
                      title: 'Address',
                      value: _address,
                    ),
                    TipsCardRow(
                      title: 'Created On',
                      value: _createdDate,
                    ),
                    _payoutModel.status == 1
                        ? SizedBox.shrink()
                        : TipsCardRow(
                            title: 'Updated On',
                            value: _updatedDate,
                          ),
                  ],
                ),
              ),
              InkWell(
                onTap: () =>
                    showModal(_payoutModel, _address, _payoutModel.address),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Container(
                          height: 30,
                          color: accent,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(' Details'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showModal(
    PayoutModel _payoutModel,
    String _subAdd,
    String _address,
  ) {
    _allRepos.showModalBar(
        context,
        Container(
          height: 600,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Payout Address",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 220,
                width: 220,
                child: QrImageView(
                  // foregroundColor: Theme.of(context).primaryColor,
                  data: _address,
                  version: QrVersions.auto,
                  size: 200,
                  gapless: true,
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      child: Center(
                        child: Text(
                          "Uh oh! Something went wrong...",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _subAdd,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () => _allRepos.copyFxn(_address, context),
                      child: Icon(IconlyLight.document),
                    ),
                  ],
                ),
              ),
              _payoutModel.status == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWid(
                            isApprove: 0,
                            fxn: () {
                              _acceptRejectPayout(
                                value: 'approve',
                                fxn: widget.approve,
                              );
                            }),
                        IconWid(
                            isApprove: 1,
                            fxn: () {
                              _acceptRejectPayout(
                                value: 'reject',
                                fxn: widget.reject,
                              );
                            }),
                        IconWid(
                          isApprove: 2,
                          fxn: () => Navigator.pop(context),
                        ),
                      ],
                    )
                  : SizedBox.shrink()
            ],
          ),
        ));
  }

  _acceptRejectPayout({String? value, Function()? fxn}) {
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
