import 'package:flutter/material.dart';
import 'package:world_info_plus/world_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocalizedName(); // Optional: loads localized names
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Info Plus Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'World Info Plus Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Country> allCountries = WorldInfoPlus.countries;
  Country? deviceCountry = WorldInfoPlus.deviceCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: allCountries.length,
        itemBuilder: (context, index) {
          final country = allCountries[index];
          return ListTile(
            leading: Image.asset(
              country.imagePath,
              width: 40,
              height: 30,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.flag),
            ),
            title: Text("(+${country.callingCode}) ${country.shortName}"),
            subtitle: Text(country.nativeName),
          );
        },
      ),
    );
  }
}
