import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/utils/strings.dart';
import 'package:bet_seed/widgets/cust_button.dart';
import 'package:bet_seed/widgets/cust_text_field.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';

class CreateAdverts extends StatefulWidget {
  const CreateAdverts({
    Key? key,
    this.data,
  }) : super(key: key);

  final Map<String, dynamic>? data;
  @override
  _CreateAdvertsState createState() => _CreateAdvertsState();
}

class _CreateAdvertsState extends State<CreateAdverts> {
  AllRepos _allRepos = AllRepos();
  GlobalKey<FormState> _adsKey = GlobalKey();

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  int _radioValue = 1;
  double _height = 200.0;
  double _width = double.infinity;

  String? _adsTitle, _adsDescription = "", _adsLink = "";

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      if (value == 1) {
        _height = 200.0;
        _width = double.infinity;
      } else {
        _height = 350.0;
        _width = 300.0;
      }
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      isLoading: isLoading,
      title: 'Create Adverts',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _adsKey,
            child: Column(
              children: [
                if (_imageFile != null)
                  Platform.isAndroid
                      ? FutureBuilder<void>(
                          future: _allRepos.retrieveLostData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<void> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return const Text(
                                  'You have not yet picked an image.',
                                  textAlign: TextAlign.center,
                                );
                              case ConnectionState.done:
                                return _allRepos.handlePreview(
                                  null,
                                  _imageFile,
                                  viewFunction(),
                                );
                              default:
                                if (snapshot.hasError) {
                                  return Text(
                                    'Image error: ${snapshot.error}}',
                                    textAlign: TextAlign.center,
                                  );
                                } else {
                                  return const Text(
                                    'You have not yet picked an image.',
                                    textAlign: TextAlign.center,
                                  );
                                }
                            }
                          },
                        )
                      : _allRepos.handlePreview(
                          null,
                          _imageFile,
                          viewFunction(),
                        )
                else
                  viewFunction(),
                SizedBox(height: 10),
                CustTextField(
                  hintText: 'Ads Title',
                  validator: _allRepos.validateEmpty,
                  onChanged: (String? val) {
                    setState(() {
                      _adsTitle = val;
                    });
                  },
                ),
                SizedBox(height: 10),
                CustTextField(
                  hintText: 'Ads Description (if any)',
                  onChanged: (String? val) {
                    setState(() {
                      _adsDescription = val;
                    });
                  },
                  maxLines: 4,
                ),
                SizedBox(height: 10),
                CustTextField(
                  hintText: 'Ads Link (if any)',
                  onChanged: (String? val) {
                    setState(() {
                      _adsLink = val;
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pop Up',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Carousel',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomButton(
                  title: 'Post Ads',
                  onTap: _postAdsFxn,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget viewFunction() {
    return _allRepos.viewFxn(
      _height,
      _width,
      () async {
        final pickedFileList =
            await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          _imageFile = pickedFileList;
        });
      },
      null,
      _imageFile,
      context,
    );
  }

  _postAdsFxn() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (_imageFile != null) {
        if (_adsKey.currentState!.validate()) {
          String _adsId = randomString(8);

          _adsKey.currentState!.save();

          Map data = {
            "adsId": _adsId,
            "adsImage": _imageFile!.path,
            "adsTitle": _adsTitle,
            "adsDescription": _adsDescription,
            "adsLink": _adsLink,
            "adsType": _radioValue.toString(),
          };

          await _allRepos.addAds(data, context);
        }
      } else {
        await _allRepos.showSnacky('Pick Image', false, context);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }
}
