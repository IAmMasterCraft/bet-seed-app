import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class CustonScaffold extends StatelessWidget {
  const CustonScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.centerTitle = true,
    this.actionIcon,
    this.selectedDate,
    this.hasDate = false,
    this.onTap,
    this.isLoading = false,
    this.onRefresh,
  }) : super(key: key);

  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool? centerTitle;
  final Widget? actionIcon;
  final String? selectedDate;
  final bool? hasDate;
  final Function()? onTap;
  final bool isLoading;
  final Future<void> Function()? onRefresh;
  @override
  Widget build(BuildContext context) {
    String date = DateFormat("dd-MM-yyyy").format(DateTime.now());

    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: ProgIndicator(),
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async => null,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: centerTitle,
            elevation: 0.0,
            actions: [
              hasDate!
                  ? InkWell(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Icon(IconlyLight.calendar),
                            SizedBox(width: 10),
                            Text(selectedDate ?? date),
                          ],
                        ),
                      ),
                    )
                  : actionIcon ?? SizedBox.shrink(),
            ],
          ),
          floatingActionButton: floatingActionButton,
          body: body,
        ),
      ),
    );
  }
}
