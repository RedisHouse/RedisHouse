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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `连接名称`
  String get connectionNameLabel {
    return Intl.message(
      '连接名称',
      name: 'connectionNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `连接地址`
  String get connectionAddressLabel {
    return Intl.message(
      '连接地址',
      name: 'connectionAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `连接端口`
  String get connectionPortLabel {
    return Intl.message(
      '连接端口',
      name: 'connectionPortLabel',
      desc: '',
      args: [],
    );
  }

  /// `连接密码`
  String get connectionPasswordLabel {
    return Intl.message(
      '连接密码',
      name: 'connectionPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `新建连接`
  String get newConnectionLabel {
    return Intl.message(
      '新建连接',
      name: 'newConnectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `测试连接`
  String get testConnectionLabel {
    return Intl.message(
      '测试连接',
      name: 'testConnectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancelLabel {
    return Intl.message(
      '取消',
      name: 'cancelLabel',
      desc: '',
      args: [],
    );
  }

  /// `保存`
  String get saveLabel {
    return Intl.message(
      '保存',
      name: 'saveLabel',
      desc: '',
      args: [],
    );
  }

  /// `编辑连接`
  String get editConnectionLabel {
    return Intl.message(
      '编辑连接',
      name: 'editConnectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `清空`
  String get clearLabel {
    return Intl.message(
      '清空',
      name: 'clearLabel',
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
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}