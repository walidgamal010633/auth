import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.onTap, this.width,
  });
  final String text;
  final Color? backgroundColor;
  final void Function()? onTap;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width:double.infinity ?? width ,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.blue,
      
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
