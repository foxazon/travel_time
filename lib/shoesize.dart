import 'package:flutter/material.dart';
//import 'dart:math';
import 'showsizes.dart';

class ShoeSizeConverter extends StatefulWidget {
  const ShoeSizeConverter({Key? key}) : super(key: key);

  @override
  _ShoeSizeConverterState createState() => _ShoeSizeConverterState();
}

class _ShoeSizeConverterState extends State<ShoeSizeConverter> {
  String selectedCountry1 = 'US';
  String selectedCountry2 = 'MX';
  String selectedGender = 'Male';
  String inputSize = '0';

  String convertShoeSize(
      String gender, String fromCountry, String toCountry, double size) {
    var genderSizes = conversionTable[gender];
    if (genderSizes == null) return "Out of range";

    if (fromCountry == 'US') {
      var exactOrLargerSize = genderSizes.keys.firstWhere(
        (k) => k >= size,
        orElse: () => -1,
      );
      if (exactOrLargerSize != -1) {
        return genderSizes[exactOrLargerSize]?[toCountry]?.toString() ??
            "Out of range";
      }
    } else {
      var correspondingUSSize = genderSizes.entries
          .firstWhere(
            (entry) =>
                entry.value[fromCountry] != null &&
                entry.value[fromCountry]! >= size,
            orElse: () => const MapEntry(-1, {'US': -1}),
          )
          .key;
      if (correspondingUSSize != -1) {
        return genderSizes[correspondingUSSize]?[toCountry]?.toString() ??
            "Out of range";
      }
    }

    // If no size is found or can be rounded up, indicate the value is out of range
    return "Out of range";
  }

  // If no size is found or can be rounded up, return original size

  final Map<String, String> countryCodes = {
    'Australia': 'Australia',
    'China': 'China',
    'Europe': 'Europe',
    'Japan': 'Japan',
    'Mexico': 'MX',
    'United Kingdom': 'UK',
    'United States': 'US',
  };

  final List<String> genders = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    double? parsedSize = double.tryParse(inputSize);
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gender Dropdown
                  const Text(
                    'Select Gender',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                    items:
                        genders.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 26.0,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // "From" Country Dropdown
                  const Text(
                    'Select Starting Country for Shoe Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedCountry1,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountry1 = newValue!;
                        if (selectedCountry1 == selectedCountry2) {
                          selectedCountry2 = countryCodes.values
                              .firstWhere((value) => value != selectedCountry1);
                        }
                      });
                    },
                    items: countryCodes.values
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 26.0,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // "To" Country Dropdown
                  const Text(
                    'Select Ending Country for Shoe Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedCountry2,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountry2 = newValue!;
                      });
                    },
                    items: countryCodes.values
                        .where((value) => value != selectedCountry1)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 26.0,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(width: 145.0, height: 20),
                  SizedBox(
                    width: 166, // Set your desired width for the TextField here
                    child: TextField(
                      maxLength: 5,
                      onChanged: (value) {
                        setState(() {
                          inputSize = value;
                        });
                      },
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                        fontSize: 24, // Set the font size as you wish
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Enter Shoe Size',
                        labelStyle: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  // Display the Converted Shoe Size
                  Text(
                    'Converted Shoe Size: ${parsedSize != null ? convertShoeSize(selectedGender, selectedCountry1, selectedCountry2, parsedSize) : "Invalid Input"}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
