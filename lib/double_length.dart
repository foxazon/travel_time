import 'package:flutter/material.dart';

class Doublelength extends StatefulWidget {
  const Doublelength({super.key});

  @override
  _DoublelengthState createState() => _DoublelengthState();
}

class _DoublelengthState extends State<Doublelength> {
  String selectedLength1 = 'Inches';
  String selectedLength2 = 'CM';
  String inputDistance = '0x0';

  // Converts distance from one unit to another
  double convertDistance(String fromUnit, String toUnit, double value) {
    Map<String, double> unitToMeter = {
      'Kilometer': 1000.0,
      'Meters': 1.0,
      'CM': 0.01,
      'MM': 0.001,
      'Miles': 1609.34,
      'Feet': 0.3048,
      'Inches': 0.0254,
    };

    double valueInMeters = value * unitToMeter[fromUnit]!;
    return valueInMeters / unitToMeter[toUnit]!;
  }

  // Converts dimensions from one unit to another
  String convertDimensions(String fromUnit, String toUnit, String dimensions) {
    List<String> parts = dimensions.split('x');
    if (parts.length != 2) return 'Invalid Input';

    double length1 = double.tryParse(parts[0]) ?? 0;
    double length2 = double.tryParse(parts[1]) ?? 0;

    double convertedLength1 = convertDistance(fromUnit, toUnit, length1);
    double convertedLength2 = convertDistance(fromUnit, toUnit, length2);

    return '${convertedLength1.toStringAsFixed(2)}x${convertedLength2.toStringAsFixed(2)}';
  }

  final Map<String, String> distanceUnits = {
    'KIL': 'Kilometer',
    'MTR': 'Meters',
    'CM': 'CM',
    'MM': 'MM',
    'MLS': 'Miles',
    'FET': 'Feet',
    'INC': 'Inches',
  };

  @override
  Widget build(BuildContext context) {
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
                    'Select Starting Lengths',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedLength1,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLength1 = newValue!;
                        if (selectedLength1 == selectedLength2) {
                          selectedLength2 = distanceUnits.values
                              .firstWhere((value) => value != selectedLength1);
                        }
                      });
                    },
                    items: distanceUnits.values
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
                    'Select Ending Lengths',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedLength2,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLength2 = newValue!;
                      });
                    },
                    items: distanceUnits.values
                        .where((value) => value != selectedLength1)
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
                      maxLength:
                          10, // Increased length to accommodate dimensions
                      onChanged: (value) {
                        setState(() {
                          inputDistance = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Enter Lengths (e.g., 1x1)',
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
                    'Converted Lengths: ${convertDimensions(selectedLength1, selectedLength2, inputDistance)}',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
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
