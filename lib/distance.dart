import 'package:flutter/material.dart';
import 'length_main.dart'; // Import the LengthMain widget

class Distance extends StatelessWidget {
  const Distance({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to LengthMain when this widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LengthMain()),
      );
    });

    // Return an empty container as this widget will navigate away immediately
    return Container();
  }
}
