import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/models/interests_model.dart';

import 'tips_card_row.dart';

class InterestsCard extends StatefulWidget {
  const InterestsCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _InterestsCardState createState() => _InterestsCardState();
}

class _InterestsCardState extends State<InterestsCard> {
  @override
  Widget build(BuildContext context) {
    var _interestModel = InterestModel.fromJson(widget.data);

    String _startDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_interestModel.startDate) * 1000));

    String _nextDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_interestModel.nextDate) * 1000));

    String _endDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_interestModel.endDate) * 1000));

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).splashColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: double.infinity,
                color: Theme.of(context).splashColor,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TipsCardRow(
                  title: 'Reference',
                  value: _interestModel.reference,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TipsCardRow(
                      title: 'Interest',
                      value: _interestModel.interest,
                    ),
                    TipsCardRow(
                      title: 'Email',
                      value: _interestModel.email,
                    ),
                    TipsCardRow(
                      title: 'Amount',
                      value: "\$ " + _interestModel.amount,
                    ),
                    TipsCardRow(
                      title: 'ROI',
                      value: _interestModel.roi,
                    ),
                    TipsCardRow(
                      title: 'Start Date',
                      value: _startDate,
                    ),
                    TipsCardRow(
                      title: 'Next Date',
                      value: _nextDate,
                    ),
                    TipsCardRow(
                      title: 'End Date',
                      value: _endDate,
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
}
