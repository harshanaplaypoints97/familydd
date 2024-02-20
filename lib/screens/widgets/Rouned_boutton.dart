import 'package:flutter/material.dart';

import '../../constant/App_color.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, required this.buttonText, required this.onPress,required this.color});

  final String buttonText;
  final Color color;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        // ignore: sort_child_properties_last
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontFamily: 'inter',
                fontSize: 14,
                color: AppColors.secondaryColor),
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
