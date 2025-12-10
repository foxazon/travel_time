import 'package:flutter/material.dart';
import 'measures_main.dart';
import 'main.dart'; // Import the file containing MyApp
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'country_codes.dart';
import 'privacy_policy.dart';

class StartupScreen extends StatelessWidget {
  final String cC1;
  final String cC2;

  const StartupScreen({Key? key, required this.cC1, required this.cC2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStartupPage(
        cC1: cC1,
        cC2: cC2,
      ),
    );
  }
}

class MyStartupPage extends StatefulWidget {
  final String cC1;
  final String cC2;
  const MyStartupPage({Key? key, required this.cC1, required this.cC2})
      : super(key: key);

  @override
  _MyStartupPageState createState() => _MyStartupPageState();
}

String description = '';

class _MyStartupPageState extends State<MyStartupPage> {
  // ignore: non_constant_identifier_names
  String description = ''; // Correct placement
  String dropdownValueC1 = 'MXN'; // Default dropdown value for cC1
  String dropdownValueC2 = 'USD'; // Default dropdown value for cC2
  final FocusNode focusNodeC1 = FocusNode();
  final FocusNode focusNodeC2 = FocusNode();

  static Map<String, String> sortCurrencyDescriptions(
      Map<String, String> descriptions) {
    var sortedEntries = descriptions.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    return Map.fromEntries(sortedEntries);
  }

  final sortedCurrencyDescriptions =
      sortCurrencyDescriptions(currencyDescriptions);
  final TextEditingController typeAheadController = TextEditingController();
  final TextEditingController typeAheadControllerC1 = TextEditingController();
  final TextEditingController typeAheadControllerC2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    description = currencyDescriptions[widget.cC1] ?? 'Default Description';
    typeAheadControllerC1.text = currencyDescriptions[dropdownValueC1] ?? '';
    typeAheadControllerC2.text = currencyDescriptions[dropdownValueC2] ?? '';
    focusNodeC1.addListener(() {
      if (focusNodeC1.hasFocus) {
        typeAheadControllerC1.clear();
      }
    });

    focusNodeC2.addListener(() {
      if (focusNodeC2.hasFocus) {
        typeAheadControllerC2.clear();
      }
    });
  }

  @override
  void dispose() {
    focusNodeC1.dispose();
    focusNodeC2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        // <-- Wrap Scaffold with Builder
        builder: (context) => Scaffold(
            backgroundColor: const Color.fromARGB(255, 234, 237, 250),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Displaying the travel.jpg image at the top
                  Expanded(
                    child: Image.asset(
                      "assets/travel.jpg",
                      fit: BoxFit.contain,
                      scale: 9.0,
                    ),
                  ),
                  Center(
                    // Wrap your column in a Center widget
                    child: Column(children: [
                      const Text(
                        'Select the Starting Currency',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TypeAheadFormField<String>(
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            dropdownValueC1 =
                                suggestion; // Make sure this is C1
                            typeAheadControllerC1.text =
                                sortedCurrencyDescriptions[suggestion]!;
                            if (dropdownValueC1 == dropdownValueC2) {
                              dropdownValueC2 = sortedCurrencyDescriptions.keys
                                  .firstWhere((key) => key != dropdownValueC1);
                            }
                          });
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                            subtitle:
                                Text(sortedCurrencyDescriptions[suggestion]!),
                          );
                        },
                        suggestionsCallback: (pattern) {
                          return sortedCurrencyDescriptions.keys.where(
                              (countryCode) =>
                                  sortedCurrencyDescriptions[countryCode]!
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()) &&
                                  countryCode != dropdownValueC1);
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: typeAheadControllerC1,
                            focusNode: focusNodeC1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 21.0), // Increase text size
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0), // Increase padding
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                      width: 2.5, color: Colors.blue)),
                            )),
                      ),
                      const Text(
                        'Select Ending Currency',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TypeAheadFormField<String>(
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            dropdownValueC2 =
                                suggestion; // Make sure this is C2
                            typeAheadControllerC2.text =
                                sortedCurrencyDescriptions[suggestion]!;
                            if (dropdownValueC1 == dropdownValueC2) {
                              dropdownValueC1 = sortedCurrencyDescriptions.keys
                                  .firstWhere((key) => key != dropdownValueC2);
                            }
                          });
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                            subtitle:
                                Text(sortedCurrencyDescriptions[suggestion]!),
                          );
                        },
                        suggestionsCallback: (pattern) {
                          return sortedCurrencyDescriptions.keys.where(
                            (countryCode) =>
                                sortedCurrencyDescriptions[countryCode]!
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase()) &&
                                countryCode != dropdownValueC2,
                          );
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: focusNodeC2,
                          controller: typeAheadControllerC2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 21.0),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 2.5, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (dropdownValueC1.isEmpty ||
                              dropdownValueC2.isEmpty) {
                            // Show error message using SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select both source and target currencies.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(
                                  cC1: dropdownValueC1,
                                  cC2: dropdownValueC2,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 17, 54, 102),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Press for',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Currency Convert',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeasuresMain(
                                cC1: dropdownValueC1,
                                cC2: dropdownValueC2,
                              ), // Navigate to MeasuresMain widget
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 17, 54, 102),
                        ),
                        child: const Text(
                          'Press for Measurements',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20.0), // Space from bottom
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PolicyInfoPage()),
                            );
                          },
                          child: const Text('Privacy Policy'),
                        ),
                      ),
                    ]),
                  )
                ])));
  }
}
