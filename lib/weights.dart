import 'package:flutter/material.dart';

class Weights extends StatefulWidget {
  const Weights({super.key});

  @override
  _WeightsState createState() => _WeightsState();
}

class _WeightsState extends State<Weights> {
  String selectedWeight1 = 'Kilogram';
  String selectedWeight2 = 'Pound';
  String inputWeight = '0';

  double convertWeight(String fromUnit, String toUnit, double value) {
    Map<String, double> unitToKg = {
      'Kilogram': 1.0,
      'Pound': 0.453592,
      'Gram': 0.001,
      'Ounce': 0.0283495,
    };

    // Convert input value to Kilogram first
    double valueInKg = value * unitToKg[fromUnit]!;

    // Convert the Kilogram value to desired output unit
    return valueInKg / unitToKg[toUnit]!;
  }

  final Map<String, String> weightUnits = {
    'KIL': 'Kilogram',
    'LBS': 'Pound',
    'GRM': 'Gram',
    'ONC': 'Ounce',
  };

  @override
  Widget build(BuildContext context) {
    double? parsedWeight = double.tryParse(inputWeight);
    return Row(children: [
      Expanded(
        child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Starting Weight Type',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedWeight1,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWeight1 = newValue!;
                            if (selectedWeight1 == selectedWeight2) {
                              selectedWeight2 = weightUnits.values.firstWhere(
                                  (value) => value != selectedWeight1);
                            }
                          });
                        },
                        items: weightUnits.values
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
                        'Select Ending Weight Type',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedWeight2,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWeight2 = newValue!;
                          });
                        },
                        items: weightUnits.values
                            .where((value) =>
                                value !=
                                selectedWeight1) // Exclude the selectedWeight1 value
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
                            145.0, // Set width as per your design requirements, this is just an approximation.
                        child: TextField(
                          maxLength: 5, // Limits the input to 5 characters
                          onChanged: (value) {
                            setState(() {
                              inputWeight = value;
                            });
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: const TextStyle(
                            fontFamily:
                                'Arial', // You can specify any font family you have added to your project
                            fontSize:
                                23, // This is the font size of the input text
                            fontWeight: FontWeight.bold, // Making the text bold
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Enter Weight',
                            labelStyle: TextStyle(
                              fontFamily: 'Arial',
                              fontSize:
                                  22, // This is the font size of the label, adjust if necessary
                              fontWeight: FontWeight.bold,
                            ),
                            counterText:
                                '', // Removes the character length counter under the TextField
                          ),
                        ),
                      ),

                      const SizedBox(
                          height: 20), // Add this line for vertical spacing
                      Text(
                        'Converted Weight: ${parsedWeight != null ? convertWeight(selectedWeight1, selectedWeight2, parsedWeight).toStringAsFixed(2) : ''}',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ]))),
      )
    ]);
  }
}
