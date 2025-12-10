import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String iconPath;
  final Widget label;
  final VoidCallback onPressed;
  final bool isSelected;

  const CustomButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (isSelected) {
              return Colors.redAccent;
            } else {
              return Colors.grey;
            }
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Adjust curvature
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 20, horizontal: 15), // Reduced padding
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 40, // Reduced width
            height: 60, // Reduced height
          ),
          const SizedBox(height: 8), // Reduced space between image and label
          label,
        ],
      ),
    );
  }
}
