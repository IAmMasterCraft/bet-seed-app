import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/models/package_model.dart';
import 'package:bet_seed/screens/create_package.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/widgets/tips_card_row.dart';

class PackageWid extends StatefulWidget {
  const PackageWid({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _PackageWidState createState() => _PackageWidState();
}

class _PackageWidState extends State<PackageWid> {
  AllRepos _allRepos = AllRepos();

  @override
  Widget build(BuildContext context) {
    var _package = PackageModel.fromJson(widget.data);

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                value: _package.title,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  TipsCardRow(
                    title: 'Amount',
                    value: "\$ " + _package.amount,
                  ),
                  _package.type == 0
                      ? TipsCardRow(
                          title: 'Quantity',
                          value: _package.quantity,
                        )
                      : TipsCardRow(
                          title: 'Duration',
                          value: "${_package.duration} month(s)",
                        ),
                  _package.type == 0
                      ? SizedBox.shrink()
                      : TipsCardRow(
                          title: _package.type == 1 ? 'Success Rate' : 'ROI',
                          value: _package.roi + "%",
                        ),
                  TipsCardRow(
                    title: 'Package ID',
                    widget: Row(
                      children: [
                        Text(_package.packageId.toUpperCase()),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () =>
                              _allRepos.copyFxn(_package.packageId, context),
                          child: Icon(
                            IconlyLight.paper,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: primaryColor,
                  ),
                  TipsCardRow(
                    title: 'Update - Delete',
                    widget: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreatePackage(
                                    type: _package.type,
                                    package: _package,
                                  ),
                                ));
                          },
                          icon: Icon(
                            IconlyLight.edit,
                            color: primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _deletePop(_package),
                          icon: Icon(
                            IconlyLight.delete,
                            color: red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deletePop(PackageModel? package) {
    _allRepos.showPopUp(
        context, Text("Are you sure you want to Delete this Package?"), [
      CupertinoButton(
        child: Text("Yes"),
        onPressed: () => _deleteFxn(package),
      ),
      CupertinoButton(
        child: Text("No"),
        onPressed: () => Navigator.pop(context),
      ),
    ], [
      TextButton(
        child: Text("Yes"),
        onPressed: () => _deleteFxn(package),
      ),
      TextButton(
        child: Text("No"),
        onPressed: () => Navigator.pop(context),
      ),
    ]);
  }

  _deleteFxn(PackageModel? package) async {
    Map data = {
      'packageId': package!.packageId,
    };
    await _allRepos.deletePackage(data, context);
    await package.refreshFxn!();
    Navigator.pop(context);
  }
}
