import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bet_seed/models/coin_model.dart';

import 'tips_card_row.dart';

class CoinHistoryCard extends StatelessWidget {
  const CoinHistoryCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    var _coinHistory = CoinHistorynModel.fromJson(data);

    String createdDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(_coinHistory.startDate)));
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
                child: TipsCardRow(
                  title: 'Package',
                  value: _coinHistory.title,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TipsCardRow(
                      title: 'Quantity',
                      value: _coinHistory.quantity.toString(),
                    ),
                    TipsCardRow(
                      title: 'Email',
                      value: _coinHistory.email,
                    ),
                    TipsCardRow(
                      title: 'Amount',
                      value: "\$ " + _coinHistory.amount,
                    ),
                    TipsCardRow(
                      title: 'Purchased On',
                      value: createdDate,
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
