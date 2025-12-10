import 'dart:core';
import 'custom_button.dart';
import 'length.dart';
import 'shoesize.dart';
import 'volume.dart';
import 'weights.dart';
import 'temperature.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'startup_screen.dart';

void main() {
  runApp(
    const StartupScreen(cC1: ' ', cC2: ' '),
  );
}

class MeasuresMain extends StatelessWidget {
  final String cC1;
  final String cC2;

  const MeasuresMain({Key? key, required this.cC1, required this.cC2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(cC1Value: cC1, cC2Value: cC2),
      child: MaterialApp(
        title: 'Travel Time',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(), // Pass cC1 and cC2 to MyHomePage
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String cC1Value = '';
  String cC2Value = '';
  String error = ''; // Store the error message here

  MyAppState({
    required this.cC1Value,
    required this.cC2Value,
  });
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);

    // If there is an error, show an error dialog and close the app
    if (appState.error.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text(appState.error),
              actions: [
                TextButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        });
      });
    }

    Widget page = Container();
    switch (selectedIndex) {
      case 0:
        page = const Weights();
        break;
      case 1:
        page = const Length();
        break;
      case 2:
        page = const Temps();
        break;
      case 3:
        page = const Volume();
        break;
      case 4:
        page = const ShoeSizeConverter();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Travel Time  - Measurements',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 234, 237,
          250), // This sets the background color for the full screen
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomButton(
                      iconPath: 'assets/scale.jpg',
                      label: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Weight',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      isSelected:
                          selectedIndex == 0, // This should stay as it is
                    ),
                    CustomButton(
                      iconPath: 'assets/tape.jpg',
                      label: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Length',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      isSelected: selectedIndex == 1,
                      // This is corrected to check for selectedIndex == 1
                    ),
                    CustomButton(
                      iconPath: 'assets/thermometer.jpg',
                      label: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Temp',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      isSelected: selectedIndex == 2,
                    ),
                    CustomButton(
                      iconPath: 'assets/volume.jpg',
                      label: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Volume',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                      isSelected: selectedIndex == 3,
                      // This is corrected to check for selectedIndex == 1
                    ),
                    CustomButton(
                      iconPath:
                          'assets/shoesize.png', // Assuming you have a thermometer icon
                      label: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Shoe Sizes',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 4;
                        });
                      },
                      isSelected: selectedIndex == 4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                width: 150,
                child: Stack(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 166, 197, 221),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage("assets/measures.png"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              const Color.fromARGB(255, 234, 237, 250)
                                  .withOpacity(0.6),
                              BlendMode.lighten),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: appState.error.isNotEmpty
                    ? Text(
                        appState.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : page,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            const StartupScreen(cC1: ' ', cC2: ' '),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 54, 102),
                  ),
                  child: const Text(
                    'Return to Main Screen',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
