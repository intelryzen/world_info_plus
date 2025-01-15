class Country {
  final String name;
  final String shortName;
  final String nativeName;
  final String capital;
  final String continent;
  final String currency;
  final String callingCode;
  final String timeZoneInCapital;
  final String alpha2;
  final String alpha3;
  final String numeric;
  final String tld;
  final String fips;
  final String? localizedName;
  final Map<String, dynamic>? extra;

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
