import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/models/subscriptions_model.dart';

import 'tips_card_row.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    var _subscription = SubscriptionModel.fromJson(data);

    String startDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(_subscription.startDate)));

    String endDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(_subscription.endDate)));
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
                color: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    TipsCardRow(title: 'Package', value: _subscription.title),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TipsCardRow(
                      title: 'Email',
                      value: _subscription.email,
                    ),
                    TipsCardRow(
                      title: 'Amount',
                      value: "\$ " + _subscription.amount,
                    ),
                    TipsCardRow(
                      title: 'Duration',
                      value: '${_subscription.duration} Month(s)',
                    ),
                    TipsCardRow(
                      title: 'Start',
                      value: startDate,
                    ),
                    TipsCardRow(
                      title: 'End',
                      value: endDate,
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
