import 'package:flutter/material.dart';

class Singlelength extends StatefulWidget {
  const Singlelength({super.key});

  @override
  _SinglelengthState createState() => _SinglelengthState();
}

class _SinglelengthState extends State<Singlelength> {
  String selectedLength1 = 'Inches';
  String selectedLength2 = 'CM';
  String inputDistance = '0';

  double convertDistance(String fromUnit, String toUnit, double value) {
    Map<String, double> unitToKg = {
      'Kilometer': 1.0,
      'Meters': .001,
      'CM': .00001,
      'MM': .000001,
      'Miles': 1.60934,
      'Feet': 0.0003048,
      'Inches': .0000254,
    };

    // Convert input value to Kilogram first
    double valueInKg = value * unitToKg[fromUnit]!;

    // Convert the Kilogram value to desired output unit
    return valueInKg / unitToKg[toUnit]!;
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
    double? parsedDistance = double.tryParse(inputDistance);
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
                      'Select Starting Length',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedLength1,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLength1 = newValue!;
                          if (selectedLength1 == selectedLength2) {
                            selectedLength2 = distanceUnits.values.firstWhere(
                                (value) => value != selectedLength1);
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
                    const SizedBox(
                        height: 20), // You can adjust the height as required
                    const Text(
                      'Select Ending Length',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedLength2,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLength2 = newValue!;
                        });
                      },
                      items: distanceUnits.values
                          .where((value) =>
                              value !=
                              selectedLength1) // Exclude the selectedWeight1 value
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
                      width:
                          175.0, // Set width as per your design requirements, this is just an approximation.
                      child: TextField(
                        maxLength: 5, // Limits the input to 5 characters
                        onChanged: (value) {
                          setState(() {
                            inputDistance = value;
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
                          labelText: 'Enter Length',
                          labelStyle: TextStyle(
                            fontFamily:
                                'Arial', // You can specify any font family you have added to your project
                            fontSize: 22, // Adjust as necessary
                            fontWeight: FontWeight.bold, // Making the text bold
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 20), // Add this line for vertical spacing
                    Text(
                      'Converted Length: ${parsedDistance != null ? convertDistance(selectedLength1, selectedLength2, parsedDistance).toStringAsFixed(2) : 'Invalid Input'}',
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
