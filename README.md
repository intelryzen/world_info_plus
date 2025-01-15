# World Info Plus Flutter Package

[![pub package](https://img.shields.io/pub/v/world_info_plus.svg)](https://pub.dev/packages/world_info_plus)
[![Score](https://img.shields.io/pub/points/world_info_plus?label=Score&logo=dart)](https://pub.dev/packages/world_info_plus/score)
[![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20macOS%20|%20Web%20|%20Windows%20|%20Linux%20-blue.svg?logo=flutter)](https://pub.dev/packages/world_info_plus)
![GitHub stars](https://img.shields.io/github/stars/intelryzen/world_info_plus)
![GitHub forks](https://img.shields.io/github/forks/intelryzen/world_info_plus)
![GitHub issues](https://img.shields.io/github/issues/intelryzen/world_info_plus)
![GitHub pull requests](https://img.shields.io/github/issues-pr/intelryzen/world_info_plus)

`world_info_plus` is a Flutter package that provides detailed information about 250 countries across the globe. This includes **calling codes**, **time zones**, **country codes** (ISO Alpha-2/Alpha-3/numeric), and more. It also supports **localized country names** based on the device's locale or language code, if available.

<img src="https://github.com/user-attachments/assets/aa064597-dffb-4a7a-acb3-88293f32b645" alt="Simulator" width="250"/>

---

## Features

- **Extensive Country Data**: Access up to 250 countries with details like capital, continent, currency, calling code, and time zone.
- **Localization**: Automatically provides localized country names based on the user's device locale (or language fallback).
- **Easy Integration**: Straightforward APIs to get all countries, retrieve device country, or fetch a specific country by its alpha2 code.
- **Optional Localization Loading**: If you wish to use `localizedName`, just call the `initializeLocalizedName()` function in your `main` before running the app.

---

## Quick Start
### Optional: Initialize Localized Names
If you **want to use** the localizedName field of each country, you **must** initialize localized names first. This will load the appropriate JSON for the device’s locale.

```dart
import 'package:world_info_plus/world_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // IMPORTANT: Call this to load localized country names, if you need them.
  await initializeLocalizedName();

  runApp(const MyApp());
}
```
### Basic Usage
```dart
// Getting all countries
List<Country> countries = WorldInfoPlus.countries;
print('Total countries: ${countries.length}');

// Getting the device locale
Locale deviceLocale = WorldInfoPlus.deviceLocale;
print('Device Locale: ${deviceLocale.toString()}');

// Getting the device country (based on device locale)
Country? deviceCountry = WorldInfoPlus.deviceCountry;
print('Device Country: ${deviceCountry?.name ?? "Unknown"}');

// Fetching a specific country by alpha2 code (e.g., "US", "KR", "FR")
Country? countryUS = WorldInfoPlus.getCountryByAlpha2('US');
print('Country Name: ${countryUS?.name}');
print('Country Localized Name: ${countryUS?.localizedName ?? "N/A"}');
```
---
## Public API
The `world_info_plus` library provides a set of static methods and properties through the `WorldInfoPlus` class:
| **API**                                        | **Return Type**       | **Description**                                                                                      |
|------------------------------------------------|------------------------|------------------------------------------------------------------------------------------------------|
| `WorldInfoPlus.countries`                      | `List<Country>`        | Returns a list of all available countries.                                                           |
| `WorldInfoPlus.deviceLocale`                   | `Locale`               | The current device locale derived from `WidgetsBinding.instance.platformDispatcher.locale`.           |
| `WorldInfoPlus.deviceCountry`                  | `Country?`             | Attempts to match the device's locale country code to a `Country`. Returns `null` if not found.       |
| `WorldInfoPlus.getCountryByAlpha2(String alpha2)` | `Country?`             | Fetches a `Country` by its ISO Alpha-2 code (e.g., "US", "FR"). Returns `null` if not found.          |
| `initializeLocalizedName()`                    | `Future<void>`         | Loads localized country names based on the device’s locale. Must be called **before** accessing `localizedName`. It is recommended to call this function in the `main` function before running the app. |

---
## Country Model
Each country is represented by the `Country` class, containing the following fields:
| **Property**        | **Type**                | **Description**                                                                                     |
|---------------------|-------------------------|-----------------------------------------------------------------------------------------------------|
| `name`              | `String`                | Official English name of the country (e.g., "United States of America").                            |
| `shortName`         | `String`                | A shorter or common English name (e.g., "USA").                                           |
| `nativeName`        | `String`                | Native name of the country in its primary local language.                                           |
| `capital`           | `String`                | Name of the country’s capital city.                                                                 |
| `continent`         | `String`                | Name of the continent (e.g., "North America", "Asia").                                              |
| `currency`          | `String`                | The official currency code (e.g., "Dollar", "Euro").                                                    |
| `callingCode`       | `String`                | Country calling code (e.g., "1" for the USA, "82" for South Korea).                                 |
| `timeZoneInCapital` | `String`                | The primary time zone of the capital city (e.g., "Asia/Seoul").                                      |
| `alpha2`            | `String`                | ISO Alpha-2 country code (e.g., "US", "KR").                                                        |
| `alpha3`            | `String`                | ISO Alpha-3 country code (e.g., "USA", "KOR").                                                      |
| `numeric`           | `String`                | ISO numeric country code (e.g., "840" for the USA).                                                 |
| `tld`               | `String`                | Country’s top-level domain (e.g., "us", "kr").                                                    |
| `fips`              | `String`                | Federal Information Processing Standards code.                                                      |
| `localizedName`     | `String?`               | Localized name if `initializeLocalizedName()` was called; otherwise `null`.                         |
| `extra`             | `Map<String, dynamic>?` | Additional information if available.                                                                |
| `imagePath`         | `String`                | Path to the country’s flag image, e.g., `"packages/world_info_plus/assets/flags/us.png"`.           |

**Example usage of** `Country`:
```dart
final country = WorldInfoPlus.getCountryByAlpha2('US');
if (country != null) {
  print('Name: ${country.name}');
  print('Short Name: ${country.shortName}');
  print('Localized Name: ${country.localizedName ?? "No localized name loaded"}');
  print('Capital: ${country.capital}');
  print('Continent: ${country.continent}');
  print('Currency: ${country.currency}');
  print('Calling Code: +${country.callingCode}');
  print('TimeZone: ${country.timeZoneInCapital}');
  print('Alpha2/Alpha3: ${country.alpha2} / ${country.alpha3}');
  print('Numeric: ${country.numeric}');
  print('TLD: ${country.tld}');
  print('FIPS: ${country.fips}');
  print('Image Path: ${country.imagePath}');
  print('Extra Info: ${country.extra}');
}
```

---
## Contributions
Contributions are welcome! Please open **[issues](https://github.com/intelryzen/world_info_plus/issues)** and **[pull requests](https://github.com/intelryzen/world_info_plus/pulls)** to improve this package.

---
