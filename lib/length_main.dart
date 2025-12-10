import 'package:flutter/material.dart';
import 'single_length.dart'; // Import Singlelength widget
import 'double_length.dart'; // Import Doublelength widget
import 'startup_screen.dart'; // Import StartupScreen widget

class LengthMain extends StatefulWidget {
  const LengthMain({Key? key}) : super(key: key);

  @override
  _LengthMainState createState() => _LengthMainState();
}

class _LengthMainState extends State<LengthMain> {
  String selectedConversion = 'Singlelength';

  // Map for display labels
  final Map<String, String> conversionLabels = {
    'Singlelength': 'Enter Single Length',
    'Doublelength': 'Enter Multiple Lengths (i.e. 2x4)',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Time - Length Conversions'),
        centerTitle: true, // Center the title
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      const StartupScreen(cC1: ' ', cC2: ' ')),
              (Route<dynamic> route) => false,
            ); // Navigate back to StartupScreen
          },
        ),
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 234, 237, 250), // Set the background color here
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(
                20.0), // Margin to keep the container in view
            decoration: BoxDecoration(
              color: Colors.white
                  .withOpacity(0.8), // Semi-transparent white background
              borderRadius:
                  BorderRadius.circular(15), // Optional: Add rounded corners
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedConversion,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedConversion = newValue!;
                    });
                  },
                  items: conversionLabels.keys
                      .map<DropdownMenuItem<String>>((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(
                        conversionLabels[key]!,
                        style: TextStyle(
                          fontSize: key == 'Doublelength'
                              ? 18.0
                              : 24.0, // Smaller font size for Doublelength
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10), // Space between dropdown and image
                Container(
                  width: 100, // Adjust width as needed
                  height: 100, // Adjust height as needed
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/tape.jpg'),
                      fit: BoxFit.cover, // Cover the container
                    ),
                    borderRadius: BorderRadius.circular(
                        10), // Optional: Add rounded corners
                  ),
                ),
                const SizedBox(height: 20), // Space between image and fields
                Expanded(
                  child: selectedConversion == 'Singlelength'
                      ? const Singlelength()
                      : selectedConversion == 'Doublelength'
                          ? const Doublelength()
                          : Container(), // Display the selected widget based on dropdown choice
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              const StartupScreen(cC1: ' ', cC2: ' ')),
                      (Route<dynamic> route) => false,
                    ); // Navigate back to StartupScreen
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[900], // White lettering
                    textStyle: const TextStyle(
                        fontSize: 16), // Adjust text size if needed
                  ),
                  child: const Text('Return to Main Screen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
