import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/models/package_model.dart';
import 'package:bet_seed/utils/decimals.dart';
import 'package:bet_seed/utils/strings.dart';
import 'package:bet_seed/widgets/cust_button.dart';
import 'package:bet_seed/widgets/cust_text_field.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';

class CreatePackage extends StatefulWidget {
  const CreatePackage({
    Key? key,
    required this.type,
    this.package,
  }) : super(key: key);

  final int type;
  final PackageModel? package;
  @override
  _CreatePackageState createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
  AllRepos _allRepos = AllRepos();
  GlobalKey<FormState> _packageKey = GlobalKey();

  String? _title = "", _amount = "", _quantity = "", _roi = "";

  double _duration = 1;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
        title: 'Create Package',
        isLoading: isLoading,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _packageKey,
              child: Column(
                children: [
                  CustTextField(
                    padding: EdgeInsets.only(bottom: 10),
                    labelText: 'Package Name',
                    hintText: 'Diamond',
                    initialValue:
                        widget.package == null ? null : widget.package!.title,
                    validator: _allRepos.validateEmpty,
                    textInputAction: TextInputAction.next,
                    onChanged: (String? val) {
                      setState(() {
                        _title = val!;
                      });
                    },
                  ),
                  CustTextField(
                    padding: EdgeInsets.only(bottom: 10),
                    labelText: 'Cost',
                    hintText: '100',
                    initialValue:
                        widget.package == null ? null : widget.package!.amount,
                    validator: _allRepos.validateEmpty,
                    inputFormatters: [DecimalTextInputFormatter()],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (String? val) {
                      setState(() {
                        _amount = val!;
                      });
                    },
                  ),
                  widget.type == 0
                      ? CustTextField(
                          padding: EdgeInsets.only(bottom: 10),
                          labelText: 'Quantity',
                          hintText: '1000',
                          initialValue: widget.package == null
                              ? null
                              : widget.package!.quantity,
                          validator: _allRepos.validateEmpty,
                          inputFormatters: [DecimalTextInputFormatter()],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (String? val) {
                            setState(() {
                              _quantity = val!;
                            });
                          },
                        )
                      : ListTile(
                          title: Text('Duration'),
                          subtitle: Platform.isAndroid
                              ? Slider(
                                  min: 1,
                                  max: 12,
                                  divisions: 12,
                                  value: _duration,
                                  onChanged: (value) {
                                    setState(() {
                                      _duration = value;
                                    });
                                  },
                                )
                              : CupertinoSlider(
                                  min: 1,
                                  max: 12,
                                  divisions: 12,
                                  value: _duration,
                                  onChanged: (value) {
                                    setState(() {
                                      _duration = value;
                                    });
                                  },
                                ),
                          trailing: Text(
                            _duration.floor().toString() + ' Month(s)',
                          ),
                        ),
                  widget.type == 0
                      ? SizedBox.shrink()
                      : CustTextField(
                          padding: EdgeInsets.only(bottom: 10),
                          labelText: widget.type == 1 ? 'Success Rate' : 'ROI',
                          hintText: widget.type == 1 ? '92.3%' : '12.5%',
                          initialValue: widget.package == null
                              ? null
                              : widget.package!.roi,
                          validator: _allRepos.validateEmpty,
                          inputFormatters: [DecimalTextInputFormatter()],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onChanged: (String? val) {
                            setState(() {
                              _roi = val!;
                            });
                          },
                        ),
                  CustomButton(
                    onTap: _createPackage,
                    title: 'Create',
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _createPackage() async {
    try {
      if (_packageKey.currentState!.validate()) {
        _packageKey.currentState!.save();

        String _packageId = randomString(8);
        Map<String, dynamic> data = {
          'packageId':
              widget.package == null ? _packageId : widget.package!.packageId,
          'title': widget.package != null && _title == ""
              ? widget.package!.title
              : _title,
          'amount': widget.package != null && _amount == ""
              ? widget.package!.amount
              : _amount,
          'duration': _duration.floor().toString(),
          'quantity': widget.package != null && _quantity == ""
              ? widget.package!.quantity
              : _quantity,
          'roi':
              widget.package != null && _roi == "" ? widget.package!.roi : _roi,
          'type': widget.type.toString(),
        };
        setState(() {
          isLoading = true;
        });

        if (widget.package == null) {
          await _allRepos.createPackage(data, context);
        } else {
          await _allRepos.updatePackage(data, context);
        }
      }
    } catch (e) {
      print(e);
      _allRepos.showSnacky(DEFAULT_ERROR, false, context);
    }
    setState(() {
      isLoading = false;
    });
  }
}
