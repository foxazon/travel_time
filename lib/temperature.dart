import 'package:flutter/material.dart';

class Temps extends StatefulWidget {
  const Temps({Key? key}) : super(key: key);

  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temps> {
  String selectedInputTemp = 'Fahrenheit';
  String selectedOutputTemp = 'Celsius';
  double? _inputTemperature;
  double? _convertedTemperature;
  final List<String> temperatureUnits = ['Fahrenheit', 'Celsius'];

  void _convertTemperature() {
    if (_inputTemperature == null) return;

    if (selectedInputTemp == 'Fahrenheit') {
      _convertedTemperature = (_inputTemperature! - 32) * 5 / 9;
      selectedOutputTemp = 'Celsius'; // Set to opposite
    } else if (selectedInputTemp == 'Celsius') {
      _convertedTemperature = (_inputTemperature! * 9 / 5) + 32;
      selectedOutputTemp = 'Fahrenheit'; // Set to opposite
    }

    setState(() {});
  }

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
                    'Select Starting Type',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedInputTemp,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedInputTemp = newValue!;
                        if (selectedInputTemp == selectedOutputTemp) {
                          // if they are the same, swap the output temp
                          selectedOutputTemp = newValue == 'Fahrenheit'
                              ? 'Celsius'
                              : 'Fahrenheit';
                        }
                        _convertTemperature();
                      });
                    },
                    items: temperatureUnits.map<DropdownMenuItem<String>>(
                      (String value) {
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
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Ending Type',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedOutputTemp,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOutputTemp = newValue!;
                        _convertTemperature();
                      });
                    },
                    items: temperatureUnits
                        .where((unit) => unit != selectedInputTemp)
                        .map<DropdownMenuItem<String>>(
                      (String value) {
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
                      },
                    ).toList(),
                  ),
                  SizedBox(
                    width: 250.0,
                    child: TextField(
                      maxLength: 5,
                      onChanged: (value) {
                        setState(() {
                          _inputTemperature = double.tryParse(value);
                          _convertTemperature();
                        });
                      },
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                        fontFamily:
                            'Arial', // You can specify any font family you have added to your project
                        fontSize: 24, // This is the font size of the input text
                        fontWeight: FontWeight.bold, // Making the text bold
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Enter Temperature',
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Converted $selectedInputTemp to $selectedOutputTemp: ${_convertedTemperature?.toStringAsFixed(2) ?? ''}',
                    style: const TextStyle(
                      fontSize:
                          20, // Adjust this value to your desired font size
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
