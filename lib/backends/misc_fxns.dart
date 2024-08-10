import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseMisc {
  Widget viewFxn(double height, double width, Function()? onTap,
      String? _exImage, XFile? _imageFile, BuildContext context);
  Widget handlePreview(String? _exImage, XFile? _imageFile, Widget viewFxn);
  Future<XFile?> retrieveLostData();
}

class MiscRepo implements BaseMisc {
  final ImagePicker _picker = ImagePicker();

  String? _retrieveDataError;
  dynamic _pickImageError;

  @override
  Widget viewFxn(double height, double width, Function()? onTap,
      String? _exImage, XFile? _imageFile, BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: _exImage != null || _imageFile != null
          ? Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  image: DecorationImage(
                    image: FileImage(File(
                      _imageFile != null ? _imageFile.path : _exImage!,
                    )),
                    fit: BoxFit.cover,
                  )),
            )
          : Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconlyLight.image,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pick Ads Image',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  Widget handlePreview(String? _exImage, XFile? _imageFile, Widget viewFxn) {
    return _previewImages(_exImage, _imageFile, viewFxn);
  }

  Widget _previewImages(String? _exImage, XFile? _imageFile, Widget viewFxn) {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_exImage != null || _imageFile != null) {
      return viewFxn;
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<XFile?> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return null;
    }
    if (response.file != null) {
      return response.file;
    } else {
      _retrieveDataError = response.exception!.code;
    }
    return response.file;
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
