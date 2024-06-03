import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? errorText;
  final Color borderColor;
  final bool obscureText;
  final Color? backgroundColor;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    this.errorText,
    this.borderColor = Colors.blue,
    this.obscureText = false,
    this.keyboardType,
    this.backgroundColor,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes the position of the shadow
          ),
        ],
      ),
      child: TextField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText
            ? _obscureText
            : false, // Only obscure text if obscureText is true
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.grey[700]),
          errorText: widget.errorText,
          border: InputBorder.none, // Remove border
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: widget.obscureText
              ? InkWell(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null, // Only show suffix icon for password fields
        ),
      ),
    );
  }
}
