class Country {
  /// Official English name of the country (e.g., "United States of America").
  final String name;

  /// A shorter or common English name (e.g., "USA").
  final String shortName;

  /// Native name of the country in its primary local language.
  final String nativeName;

  /// Name of the country’s capital city.
  final String capital;

  /// Name of the continent (e.g., "North America", "Asia").
  final String continent;

  /// The official currency code (e.g., "Dollar", "Euro").
  final String currency;

  /// Country calling code (e.g., "1" for the USA, "82" for South Korea).
  final String callingCode;

  /// The primary time zone of the capital city (e.g., "Asia/Seoul").
  final String timeZoneInCapital;

  /// ISO Alpha-2 country code (e.g., "US", "KR").
  final String alpha2;

  /// ISO Alpha-3 country code (e.g., "USA", "KOR").
  final String alpha3;

  /// ISO numeric country code (e.g., "840" for the USA).
  final String numeric;

  /// Country’s top-level domain (e.g., "us", "kr").
  final String tld;

  /// Federal Information Processing Standards code.
  final String fips;

  /// Future<void> initializeLocalizedName() Must be called before accessing localizedName.
  /// It is recommended to call this function in the main function before running the app.
  final String? localizedName;

  /// Additional information if available.
  final Map<String, dynamic>? extra;

  /// Path to the country’s flag image,
  /// e.g., "packages/world_info_plus/assets/flags/us.png".
  String get imagePath =>
      "packages/world_info_plus/assets/flags/${alpha2.toLowerCase()}.png";

  const Country({
    required this.alpha2,
    required this.name,
    required this.shortName,
    required this.nativeName,
    required this.capital,
    required this.continent,
    required this.currency,
    required this.callingCode,
    required this.timeZoneInCapital,
    required this.alpha3,
    required this.numeric,
    required this.tld,
    required this.fips,
    this.localizedName,
    this.extra,
  });

  factory Country.fromMap(Map<String, dynamic> map,
      {String? localizedName, Map<String, dynamic>? extraMap}) {
    return Country(
      alpha2: map['alpha2'],
      name: map['name'],
      shortName: map['shortName'],
      nativeName: map['nativeName'],
      capital: map['capital'],
      continent: map['continent'],
      currency: map['currency'],
      callingCode: map['callingCode'],
      timeZoneInCapital: map['timeZoneInCapital'],
      alpha3: map['alpha3'],
      numeric: map['numeric'],
      tld: map['tld'],
      fips: map['fips'],
      localizedName: localizedName,
      extra: extraMap,
    );
  }

  @override
  String toString() {
    return '''
Country {
  name: $name,
  shortName: $shortName,
  nativeName: $nativeName,
  capital: $capital,
  continent: $continent,
  currency: $currency,
  callingCode: $callingCode,
  timeZoneInCapital: $timeZoneInCapital,
  alpha2: $alpha2,
  alpha3: $alpha3,
  numeric: $numeric,
  tld: $tld,
  fips: $fips,
  localizedName: $localizedName,
  imagePath: $imagePath,
  extra: $extra
}
''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Country) return false;
    return alpha2 == other.alpha2;
  }

  @override
  int get hashCode => alpha2.hashCode;
}
