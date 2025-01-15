import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:world_info_plus/src/model/country_model.dart';
import 'package:world_info_plus/src/resource/country_info.dart';
import 'package:world_info_plus/src/resource/extra_info.dart';

abstract class WorldInfoPlus {
  static final List<Country> _countries = [];
  static final Map<String, String> _localizedNames = {};

  static Locale get _deviceLocale =>
      WidgetsBinding.instance.platformDispatcher.locale;

  static String _getAssetPath(String locale) {
    return 'packages/world_info_plus/assets/localized_names/$locale.json';
  }

  /// Initialize localized names based on the device's locale
  static Future<void> _initializeLocalizedName() async {
    try {
      final String assetPath = _getAssetPath(_deviceLocale.toString());
      final String jsonString = await rootBundle.loadString(assetPath);
      _localizedNames.clear();
      _localizedNames.addAll(Map<String, String>.from(json.decode(jsonString)));
      return;
    } catch (e) {
      // Try using only the language code if the specific locale is not found
      final String fallbackLanguagePath =
          _getAssetPath(_deviceLocale.languageCode);
      try {
        final String jsonString =
            await rootBundle.loadString(fallbackLanguagePath);
        _localizedNames.clear();
        _localizedNames
            .addAll(Map<String, String>.from(json.decode(jsonString)));
        return;
      } catch (e) {
        // If neither the specific locale nor language code is found, return without any changes
        debugPrint(
            'Failed to load fallback language: ${_deviceLocale.languageCode}');
        return;
      }
    }
  }

  /// Returns a list of all available countries.
  static List<Country> get countries {
    if (_countries.isEmpty) {
      countryInfo.forEach((alpha2, infoMap) {
        _countries.add(
          Country.fromMap(
            infoMap,
            localizedName: _localizedNames[alpha2],
            extraMap: extraInfo[alpha2],
          ),
        );
      });
    }
    return _countries;
  }

  /// The current device locale derived from WidgetsBinding.instance.platformDispatcher.locale.
  static Locale get deviceLocale => _deviceLocale;

  /// Attempts to match the device's locale country code to a Country. Returns null if not found.
  static Country? get deviceCountry {
    final countryCode = _deviceLocale.countryCode;
    if (countryCode == null) {
      return null;
    }
    return getCountryByAlpha2(countryCode);
  }

  /// Fetches a Country by its ISO Alpha-2 code (e.g., "US", "FR"). Returns null if not found.
  static Country? getCountryByAlpha2(String alpha2) {
    alpha2 = alpha2.toUpperCase();
    final Map<String, dynamic>? infoMap = countryInfo[alpha2];
    if (infoMap == null) {
      return null;
    }
    return Country.fromMap(infoMap,
        localizedName: _localizedNames[alpha2], extraMap: extraInfo[alpha2]);
  }
}

/// Loads localized country names based on the device’s locale. Must be called before accessing localizedName.
/// It is recommended to call this function in the main function before running the app.
Future<void> initializeLocalizedName() async {
  await WorldInfoPlus._initializeLocalizedName();
}
