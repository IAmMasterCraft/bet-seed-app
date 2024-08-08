import 'package:fluro/fluro.dart' as route;
import 'package:flutter/material.dart';
import 'package:bet_seed/screens/adverts.dart';
import 'package:bet_seed/screens/coin_purchases.dart';
import 'package:bet_seed/screens/coins.dart';
import 'package:bet_seed/screens/completed_investments.dart';
import 'package:bet_seed/screens/completed_payouts.dart';
import 'package:bet_seed/screens/completed_subscriptions.dart';
import 'package:bet_seed/screens/create_adverts.dart';
import 'package:bet_seed/screens/failed_investments.dart';
import 'package:bet_seed/screens/failed_payouts.dart';
import 'package:bet_seed/screens/free_tips.dart';
import 'package:bet_seed/screens/home.dart';
import 'package:bet_seed/screens/interests.dart';
import 'package:bet_seed/screens/investments.dart';
import 'package:bet_seed/screens/notifications.dart';
import 'package:bet_seed/screens/package_coins.dart';
import 'package:bet_seed/screens/package_investments.dart';
import 'package:bet_seed/screens/package_subscriptions.dart';
import 'package:bet_seed/screens/past-tips.dart';
import 'package:bet_seed/screens/payouts.dart';
import 'package:bet_seed/screens/pending_investments.dart';
import 'package:bet_seed/screens/pending_payouts.dart';
import 'package:bet_seed/screens/premium_tips.dart';
import 'package:bet_seed/screens/running_investments.dart';
import 'package:bet_seed/screens/sign_in.dart';
import 'package:bet_seed/screens/subscriptions.dart';
import 'package:bet_seed/screens/tips.dart';
import 'package:bet_seed/screens/users.dart';

class FluroRouter {
  static final router = route.FluroRouter();

  //! Home
  static route.Handler _homeHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return MyHomePage();
  });

  //! SignIn
  static route.Handler _signInHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return SignIn();
  });
  //! Users
  static route.Handler _usersHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Users();
  });

  //! Tips
  static route.Handler _tipsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Tips();
  });

  //! FreeTips
  static route.Handler _freetipsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return FreeTips();
  });

  //! PremiumTips
  static route.Handler _premiumtipsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return PremiumTips();
  });

  //! PastTips
  static route.Handler _pasttipsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return PastTips();
  });

  //! Coins
  static route.Handler _coinsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Coins();
  });

  //! Coin Purchases
  static route.Handler _coinpurchaseHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return CoinPurchases();
  });

  //! Coin Packages
  static route.Handler _coinpackageHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return PackageCoins();
  });

  //! Subscriptions
  static route.Handler _subscriptionsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Subscriptions();
  });

  //! PackageSubscriptions
  static route.Handler _packagesubscriptionsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return PackageSubscriptions();
  });

  //! CompletedSubscriptions
  static route.Handler _completedsubscriptionsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return CompletedSubscriptions();
  });

  //! Investments
  static route.Handler _investmentsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Investments();
  });

  //! PackageInvestments
  static route.Handler _packageinvestmentsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return PackageInvestments();
  });

  //! PendingInvestments
  static route.Handler _pendinginvestmentsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return PendingInvestments();
  });

  //! RunningInvestments
  static route.Handler _runninginvestmentsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return RunningInvestments();
  });

  //! CompletedInvestments
  static route.Handler _completedinvestmentsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return CompletedInvestments();
  });

  //! FailedInvestments
  static route.Handler _failedinvestmentsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return FailedInvestments();
  });

  //! Payouts
  static route.Handler _payoutsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Payouts();
  });

  //! PendingPayouts
  static route.Handler _pendingpayoutsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return PendingPayouts();
  });

  //! CompletedPayouts
  static route.Handler _completedpayoutsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return CompletedPayouts();
  });

  //! FailedPayouts
  static route.Handler _failedpayoutsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return FailedPayouts();
  });

  //! Interests
  static route.Handler _interestsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Interests();
  });

  //! Adverts
  static route.Handler _advertsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Adverts();
  });

  //! CreateAdverts
  static route.Handler _createadvertsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return CreateAdverts();
  });

  //! Notifications
  static route.Handler _notificationsHandler = route.Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Notifications();
  });

  static void setupRouter() {
    //! Home
    router.define(
      '/home',
      handler: _homeHandler,
      transitionType: route.TransitionType.native,
    );

//! Sign In
    router.define(
      '/sign-in',
      handler: _signInHandler,
      transitionType: route.TransitionType.native,
    );

    //! Users
    router.define(
      '/users',
      handler: _usersHandler,
      transitionType: route.TransitionType.native,
    );

    //! Tips
    router.define(
      '/tips',
      handler: _tipsHandler,
      transitionType: route.TransitionType.native,
    );

    //! FreeTips
    router.define(
      '/free-tips',
      handler: _freetipsHandler,
      transitionType: route.TransitionType.native,
    );
    //! PremiumTips
    router.define(
      '/premium-tips',
      handler: _premiumtipsHandler,
      transitionType: route.TransitionType.native,
    );
    //! PastTips
    router.define(
      '/past-tips',
      handler: _pasttipsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Coins
    router.define(
      '/coins',
      handler: _coinsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Coin Purchases
    router.define(
      '/coin-purchase',
      handler: _coinpurchaseHandler,
      transitionType: route.TransitionType.native,
    );

    //! Coin Package
    router.define(
      '/coin-packages',
      handler: _coinpackageHandler,
      transitionType: route.TransitionType.native,
    );

    //! Subscriptions
    router.define(
      '/subscriptions',
      handler: _subscriptionsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Package Subscriptions
    router.define(
      '/package-subscriptions',
      handler: _packagesubscriptionsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Completed Subscriptions
    router.define(
      '/completed-subscriptions',
      handler: _completedsubscriptionsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Investments
    router.define(
      '/investments',
      handler: _investmentsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Package Investments
    router.define(
      '/package-investments',
      handler: _packageinvestmentsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Pending Investments
    router.define(
      '/pending-investments',
      handler: _pendinginvestmentsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Running Investments
    router.define(
      '/running-investments',
      handler: _runninginvestmentsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Completed Investments
    router.define(
      '/completed-investments',
      handler: _completedinvestmentsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Failed Investments
    router.define(
      '/failed-investments',
      handler: _failedinvestmentsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Payouts
    router.define(
      '/payouts',
      handler: _payoutsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Pending Payouts
    router.define(
      '/pending-payouts',
      handler: _pendingpayoutsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Completed Payouts
    router.define(
      '/completed-payouts',
      handler: _completedpayoutsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Failed Payouts
    router.define(
      '/failed-payouts',
      handler: _failedpayoutsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Interests
    router.define(
      '/interests',
      handler: _interestsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Adverts
    router.define(
      '/adverts',
      handler: _advertsHandler,
      transitionType: route.TransitionType.native,
    );

    //! Create Adverts
    router.define(
      '/create-adverts',
      handler: _createadvertsHandler,
      transitionType: route.TransitionType.native,
    );
    //! Notifications
    router.define(
      '/notifications',
      handler: _notificationsHandler,
      transitionType: route.TransitionType.native,
    );
  }
}
