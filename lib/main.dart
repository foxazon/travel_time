import 'dart:core';
import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'country_codes.dart';

import 'cC1_to_cC2.dart';
import 'cC2_to_cC1.dart';
import 'c1_to_c2_vol.dart';
import 'c1_to_c2_wt.dart';
import 'api_call.dart';
import 'startup_screen.dart';

void main() {
  runApp(
    const StartupScreen(cC1: ' ', cC2: ' '),
  );
}

class MyApp extends StatelessWidget {
  final String todaysRate = '';
  final String cC1;
  final String cC2;

  const MyApp({Key? key, required this.cC1, required this.cC2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          API_Call(todaysRate: '999999', cC1Value: cC1, cC2Value: cC2),
      child: MaterialApp(
        title: 'Travel Time',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 203, 225, 239)),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<API_Call>(context);

    // If there is an error, close the app
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

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = C1ToC2_vol(cC1: appState.cC1Value, cC2: appState.cC2Value);
        break;
      case 1:
        page = C1ToC2_wt(cC1: appState.cC1Value, cC2: appState.cC2Value);
        break;
      case 2:
        page = Cc1ToCc2(cC1: appState.cC1Value, cC2: appState.cC2Value);
        break;
      case 3:
        page = Cc2ToCc1(cC1: appState.cC1Value, cC2: appState.cC2Value);
        break;
      default:
        page = Container(); // Define a default widget here
    }

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 234, 237, 250), // Set background color
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Travel Time - Today\'s Rate: ${appState.todaysRate}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    '   From Currency: ',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currencyDescriptions[appState.cC1Value] ?? 'Not Selected',
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  const Text(
                    '     To Currency: ',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currencyDescriptions[appState.cC2Value] ?? 'Not Selected',
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    iconPath: 'assets/dollar.png',
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(appState.cC1Value,
                            style: const TextStyle(fontSize: 16)),
                        const Text('to', style: TextStyle(fontSize: 16)),
                        Text(appState.cC2Value,
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    isSelected: selectedIndex == 2,
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    iconPath: 'assets/dollar.png',
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(appState.cC2Value,
                            style: const TextStyle(fontSize: 16)),
                        const Text('to', style: TextStyle(fontSize: 16)),
                        Text(appState.cC1Value,
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    isSelected: selectedIndex == 3,
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    iconPath: 'assets/gaspump.jpg',
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Price per', style: TextStyle(fontSize: 16)),
                        Text(
                          appState.cC1Value == 'USD'
                              ? 'USD Gallon'
                              : '${appState.cC1Value} Liter',
                        ),
                        const Text('to', style: TextStyle(fontSize: 16)),
                        Text(
                          appState.cC2Value == 'USD'
                              ? 'USD Gallon'
                              : '${appState.cC2Value} Liter',
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    isSelected: selectedIndex == 0,
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    iconPath: 'assets/scale.jpg',
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Price per', style: TextStyle(fontSize: 16)),
                        Text(
                          appState.cC1Value == 'USD'
                              ? 'USD Pound'
                              : '${appState.cC1Value} Kilo',
                        ),
                        const Text('to', style: TextStyle(fontSize: 16)),
                        Text(
                          appState.cC2Value == 'USD'
                              ? 'USD Pound'
                              : '${appState.cC2Value} Kilo',
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    isSelected: selectedIndex == 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 234, 237, 250),
                  ),
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage("assets/exchange.png"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6),
                          BlendMode.lighten,
                        ),
                      ),
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
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
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
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 17, 54, 102)),
                  child: const Text('Return to Main Screen'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
