import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bet_seed/backends/admin_user.dart';
import 'package:bet_seed/backends/call_fxns.dart';
import 'package:bet_seed/backends/database.dart';
import 'package:bet_seed/backends/database2.dart';
import 'package:bet_seed/backends/misc_fxns.dart';
import 'package:bet_seed/backends/validators.dart';

class AllRepos {
  CallFunctions _callFunctions = CallFunctions();
  MiscRepo _miscRepo = MiscRepo();
  DatabaseRepo _databaseRepo = DatabaseRepo();
  AdminDB _adminDB = AdminDB();

  ValidatorsFxn _validatorsFxn = ValidatorsFxn();
  DatabaseRepo2 _databaseRepo2 = DatabaseRepo2();

  //?
  showSnacky(String msg, bool isSuccess, BuildContext context,
          {Map<String, String>? args, String extra2 = ''}) =>
      _callFunctions.showSnacky(msg, isSuccess, context,
          args: args, extra2: extra2);

  //?
  showPicker(
    context, {
    List<dynamic>? children,
    Function(int?)? onSelectedItemChanged,
    Function(String?)? onChanged,
    bool hasTrns = true,
  }) =>
      _callFunctions.showPicker(
        context,
        children: children,
        onSelectedItemChanged: onSelectedItemChanged,
        onChanged: onChanged,
        hasTrns: hasTrns,
      );

  //?

  showPopUp(
    BuildContext context,
    Widget content,
    List<CupertinoButton> iosActions,
    List<TextButton> androidActions, {
    IconData? icon,
    String? msg,
    Color? color,
    bool barrierDismissible = true,
  }) =>
      _callFunctions.showPopUp(
        context,
        content,
        iosActions,
        androidActions,
        barrierDismissible: barrierDismissible,
      );

//?

  showModalBarAction(
    BuildContext context,
    Widget child,
    List<Widget> action,
  ) =>
      _callFunctions.showModalBarAction(
        context,
        child,
        action,
      );

  //?

  showModalBar(
    BuildContext context,
    Widget content, {
    bool? isDismissible,
  }) =>
      _callFunctions.showModalBar(
        context,
        content,
        isDismissible: isDismissible,
      );

//?
  copyFxn(String text, BuildContext context) =>
      _callFunctions.copyFxn(text, context);
  //! Misc

  //?
  Widget viewFxn(double height, double width, Function()? onTap,
          String? _exImage, XFile? _imageFile, BuildContext context) =>
      _miscRepo.viewFxn(height, width, onTap, _exImage, _imageFile, context);

  //?
  Widget handlePreview(String? _exImage, XFile? _imageFile, Widget viewFxn) =>
      _miscRepo.handlePreview(_exImage, _imageFile, viewFxn);

  //?s
  Future<XFile?> retrieveLostData() => _miscRepo.retrieveLostData();

  //?

  //! Databse Repo

  //?
  addTips(Map data, BuildContext context) =>
      _databaseRepo.addTips(data, context);

  //?
  wlTips(Map data, BuildContext context) => _databaseRepo.wlTips(data, context);

  //?
  deleteTips(Map data, BuildContext context) =>
      _databaseRepo.deleteTips(data, context);

  //?

  Future<List> getTips(Map data, BuildContext context) =>
      _databaseRepo.getTips(data, context);

  //?
  updateTips(Map data, BuildContext context) =>
      _databaseRepo.updateTips(data, context);

  //?

  addAds(Map data, BuildContext context) => _databaseRepo.addAds(data, context);
  deleteAds(Map data, BuildContext context) =>
      _databaseRepo.deleteAds(data, context);
  Future<List> getAds(Map data, BuildContext context) =>
      _databaseRepo.getAds(data, context);
  updateAds(Map data, BuildContext context) =>
      _databaseRepo.updateAds(data, context);

//?

  postNotification(Map data, BuildContext context) =>
      _databaseRepo.postNotification(data, context);
  deleteNotification(Map data, BuildContext context) =>
      _databaseRepo.deleteNotification(data, context);
  Future<List> getNotifications(BuildContext context) =>
      _databaseRepo.getNotifications(context);

  //!

  String? validateEmpty(String? value) => _validatorsFxn.validateEmpty(value);

  String? validateName(String? value) => _validatorsFxn.validateName(value);
  String? validateEmail(String? value) => _validatorsFxn.validateEmail(value);
  String? validatePassword(String? value) =>
      _validatorsFxn.validatePassword(value);

//!

  Future<bool> signIn(Map data, BuildContext context) =>
      _adminDB.signIn(data, context);
  Future<bool> logOut(context) => _adminDB.logOut(context);

  Future<Map<String, dynamic>> getUser(Map data) => _adminDB.getUser(data);
  //!

  //?
  Future<List> getUsers() => _databaseRepo2.getUsers();
  Future<List> getHistory(Map data) => _databaseRepo2.getHistory(data);
  Future<List> getPayouts(Map data) => _databaseRepo2.getPayouts(data);
  Future<List> getInterests() => _databaseRepo2.getInterests();

  Future<List> getPackages(Map data) => _databaseRepo2.getPackages(data);
  Future<List> getInvestHistory(Map data) =>
      _databaseRepo2.getInvestHistory(data);
  Future<List> getRunningInvestments() =>
      _databaseRepo2.getRunningInvestments();

  //?
  Future<bool> adminBlock(Map data, context) =>
      _databaseRepo2.adminBlock(data, context);
  Future<bool> createPackage(Map data, context) =>
      _databaseRepo2.createPackage(data, context);
  Future<bool> updatePackage(Map data, context) =>
      _databaseRepo2.updatePackage(data, context);
  Future<bool> deletePackage(Map data, context) =>
      _databaseRepo2.deletePackage(data, context);
  Future<bool> approveRejectPayout(Map data, context) =>
      _databaseRepo2.approveRejectPayout(data, context);

  Future<bool> approveRejectInvestment(Map data, context) =>
      _databaseRepo2.approveRejectInvestment(data, context);
}
