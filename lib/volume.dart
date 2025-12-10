import 'package:flutter/material.dart';

class Volume extends StatefulWidget {
  const Volume({super.key});

  @override
  _VolumeState createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  String selectedVolume1 = 'Liter';
  String selectedVolume2 = 'Gallon';
  String inputVolume = '0';

  double convertVolume(String fromUnit, String toUnit, double value) {
    Map<String, double> unitToLiter = {
      'Liter': 1.0,
      'Milliliter': 0.001,
      'Gallon': 3.78541,
      'Quart': 0.946353,
      'Pint': 0.473176,
      'Fluid Ounce': 0.0295735,
    };

    // Convert input value to Liter first
    double valueInLiter = value * unitToLiter[fromUnit]!;

    // Convert the Liter value to desired output unit
    return valueInLiter / unitToLiter[toUnit]!;
  }

  final Map<String, String> volumeUnits = {
    'LTR': 'Liter',
    'ML': 'Milliliter',
    'GAL': 'Gallon',
    'QT': 'Quart',
    'PT': 'Pint',
    'OZ': 'Fluid Ounce',
  };

  @override
  Widget build(BuildContext context) {
    double? parsedVolume = double.tryParse(inputVolume);
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Starting Volume',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedVolume1,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedVolume1 = newValue!;
                          if (selectedVolume1 == selectedVolume2) {
                            selectedVolume2 = volumeUnits.values.firstWhere(
                                (value) => value != selectedVolume1);
                          }
                        });
                      },
                      items: volumeUnits.values
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
                    const Text(
                      'Select Ending Volume',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedVolume2,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedVolume2 = newValue!;
                        });
                      },
                      items: volumeUnits.values
                          .where((value) => value != selectedVolume1)
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
                    SizedBox(
                      width: 175.0,
                      child: TextField(
                        maxLength: 5,
                        onChanged: (value) {
                          setState(() {
                            inputVolume = value;
                          });
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: const TextStyle(
                          fontFamily:
                              'Arial', // You can specify any font family you have added to your project
                          fontSize:
                              24, // This is the font size of the input text
                          fontWeight: FontWeight.bold, // Making the text bold
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Enter Volume',
                          labelStyle: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Converted Volume: ${parsedVolume != null ? convertVolume(selectedVolume1, selectedVolume2, parsedVolume).toStringAsFixed(2) : 'Invalid Input'}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
