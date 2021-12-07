// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settings_themeMode {
    return Intl.message(
      'Theme',
      name: 'settings_themeMode',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get settings_themeModeSystem {
    return Intl.message(
      'System',
      name: 'settings_themeModeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settings_themeModeLight {
    return Intl.message(
      'Light',
      name: 'settings_themeModeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settings_themeModeDark {
    return Intl.message(
      'Dark',
      name: 'settings_themeModeDark',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng việt`
  String get settings_languageVietnamese {
    return Intl.message(
      'Tiếng việt',
      name: 'settings_languageVietnamese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settings_languageEnglish {
    return Intl.message(
      'English',
      name: 'settings_languageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language {
    return Intl.message(
      'Language',
      name: 'settings_language',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Login by FaceID`
  String get login_face_id {
    return Intl.message(
      'Login by FaceID',
      name: 'login_face_id',
      desc: '',
      args: [],
    );
  }

  /// `Free trading for life`
  String get splash_title1 {
    return Intl.message(
      'Free trading for life',
      name: 'splash_title1',
      desc: '',
      args: [],
    );
  }

  /// `Saving transaction with the cheapest fee in the market`
  String get splash_sub1 {
    return Intl.message(
      'Saving transaction with the cheapest fee in the market',
      name: 'splash_sub1',
      desc: '',
      args: [],
    );
  }

  /// `Choose a free beautiful number account`
  String get splash_title2 {
    return Intl.message(
      'Choose a free beautiful number account',
      name: 'splash_title2',
      desc: '',
      args: [],
    );
  }

  /// `Choose the account number you like`
  String get splash_sub2 {
    return Intl.message(
      'Choose the account number you like',
      name: 'splash_sub2',
      desc: '',
      args: [],
    );
  }

  /// `With only 3 minutes to open an account`
  String get splash_title3 {
    return Intl.message(
      'With only 3 minutes to open an account',
      name: 'splash_title3',
      desc: '',
      args: [],
    );
  }

  /// `Browse and have an account within 24 hours`
  String get splash_sub3 {
    return Intl.message(
      'Browse and have an account within 24 hours',
      name: 'splash_sub3',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get user_name {
    return Intl.message(
      'Username',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Input username`
  String get please_input_user {
    return Intl.message(
      'Input username',
      name: 'please_input_user',
      desc: '',
      args: [],
    );
  }

  /// `Input password`
  String get please_input_password {
    return Intl.message(
      'Input password',
      name: 'please_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account? `
  String get not_account {
    return Intl.message(
      'Don\'t have account? ',
      name: 'not_account',
      desc: '',
      args: [],
    );
  }

  /// `Have account`
  String get have_account {
    return Intl.message(
      'Have account',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_pass {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_pass',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Account is empty`
  String get empty_account {
    return Intl.message(
      'Account is empty',
      name: 'empty_account',
      desc: '',
      args: [],
    );
  }

  /// `Password is empty`
  String get empty_password {
    return Intl.message(
      'Password is empty',
      name: 'empty_password',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Network Error`
  String get network_error {
    return Intl.message(
      'Network Error',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Order note`
  String get order_note {
    return Intl.message(
      'Order note',
      name: 'order_note',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get category {
    return Intl.message(
      'Menu',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Assets`
  String get assets {
    return Intl.message(
      'Assets',
      name: 'assets',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get profit {
    return Intl.message(
      'Profit',
      name: 'profit',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Permission buy`
  String get permission_to_buy {
    return Intl.message(
      'Permission buy',
      name: 'permission_to_buy',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Up to`
  String get up_to {
    return Intl.message(
      'Up to',
      name: 'up_to',
      desc: '',
      args: [],
    );
  }

  /// `Min volume`
  String get min_VOLUME {
    return Intl.message(
      'Min volume',
      name: 'min_VOLUME',
      desc: '',
      args: [],
    );
  }

  /// `Invest to`
  String get invest_to {
    return Intl.message(
      'Invest to',
      name: 'invest_to',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Invest`
  String get invest {
    return Intl.message(
      'Invest',
      name: 'invest',
      desc: '',
      args: [],
    );
  }

  /// `Invest Information`
  String get invest_information {
    return Intl.message(
      'Invest Information',
      name: 'invest_information',
      desc: '',
      args: [],
    );
  }

  /// `Invest money`
  String get invest_money {
    return Intl.message(
      'Invest money',
      name: 'invest_money',
      desc: '',
      args: [],
    );
  }

  /// `Input money`
  String get input_invest_money {
    return Intl.message(
      'Input money',
      name: 'input_invest_money',
      desc: '',
      args: [],
    );
  }

  /// `Invest time`
  String get invest_time {
    return Intl.message(
      'Invest time',
      name: 'invest_time',
      desc: '',
      args: [],
    );
  }

  /// `Months`
  String get month {
    return Intl.message(
      'Months',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Select Product`
  String get select_product {
    return Intl.message(
      'Select Product',
      name: 'select_product',
      desc: '',
      args: [],
    );
  }

  /// `Interest Expect`
  String get interest_expect {
    return Intl.message(
      'Interest Expect',
      name: 'interest_expect',
      desc: '',
      args: [],
    );
  }

  /// `Interest Money`
  String get interest_money {
    return Intl.message(
      'Interest Money',
      name: 'interest_money',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Interst TT`
  String get interest_tt {
    return Intl.message(
      'Interst TT',
      name: 'interest_tt',
      desc: '',
      args: [],
    );
  }

  /// `Interst ST`
  String get interest_st {
    return Intl.message(
      'Interst ST',
      name: 'interest_st',
      desc: '',
      args: [],
    );
  }

  /// `Receive money`
  String get receive_money {
    return Intl.message(
      'Receive money',
      name: 'receive_money',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get coupon {
    return Intl.message(
      'Coupon',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `Interest now`
  String get interest_now {
    return Intl.message(
      'Interest now',
      name: 'interest_now',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Payment type`
  String get pay_type {
    return Intl.message(
      'Payment type',
      name: 'pay_type',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Payment`
  String get transfer_payment {
    return Intl.message(
      'Transfer Payment',
      name: 'transfer_payment',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Transfer information`
  String get transfer_information {
    return Intl.message(
      'Transfer information',
      name: 'transfer_information',
      desc: '',
      args: [],
    );
  }

  /// `Interest`
  String get interest {
    return Intl.message(
      'Interest',
      name: 'interest',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Bond code`
  String get bond_code {
    return Intl.message(
      'Bond code',
      name: 'bond_code',
      desc: '',
      args: [],
    );
  }

  /// `Invest start`
  String get invest_start {
    return Intl.message(
      'Invest start',
      name: 'invest_start',
      desc: '',
      args: [],
    );
  }

  /// `Invest end`
  String get invest_end {
    return Intl.message(
      'Invest end',
      name: 'invest_end',
      desc: '',
      args: [],
    );
  }

  /// `Fee`
  String get fee {
    return Intl.message(
      'Fee',
      name: 'fee',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Total invest`
  String get invest_total {
    return Intl.message(
      'Total invest',
      name: 'invest_total',
      desc: '',
      args: [],
    );
  }

  /// `Bond assets`
  String get bond_assets {
    return Intl.message(
      'Bond assets',
      name: 'bond_assets',
      desc: '',
      args: [],
    );
  }

  /// `Bond history`
  String get bond_history {
    return Intl.message(
      'Bond history',
      name: 'bond_history',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Instructions transfers`
  String get instructions_transfers {
    return Intl.message(
      'Instructions transfers',
      name: 'instructions_transfers',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get account_user {
    return Intl.message(
      'User',
      name: 'account_user',
      desc: '',
      args: [],
    );
  }

  /// `Open on`
  String get open_on {
    return Intl.message(
      'Open on',
      name: 'open_on',
      desc: '',
      args: [],
    );
  }

  /// `Bank account`
  String get bank_account {
    return Intl.message(
      'Bank account',
      name: 'bank_account',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content_transfer {
    return Intl.message(
      'Content',
      name: 'content_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Policy`
  String get policy_use {
    return Intl.message(
      'Policy',
      name: 'policy_use',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get contact_support {
    return Intl.message(
      'Support',
      name: 'contact_support',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
