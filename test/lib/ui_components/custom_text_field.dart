import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.keyboardType,
    required this.prefixicon,
    required this.labelText,
    this.suffixicon, this.onSaved,
  });
  final TextInputType? keyboardType;
  final IconData prefixicon;
  final IconData? suffixicon;
  final String labelText;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onSaved:onSaved ,
        keyboardType: keyboardType ?? TextInputType.emailAddress,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black),
          ),

          prefixIcon: Icon(prefixicon, color: Colors.black),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(suffixicon, color: Colors.black),
          ),
          labelStyle: TextStyle(color: Colors.black),

          labelText: labelText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'this field is required';
          }
          return null;
        },
      ),
    );
  }
}
