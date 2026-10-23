import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String hint;
  final IconData prefixIcon; // Иконка слева (замочек)
  
  final TextEditingController? controller;

  const PasswordTextField({
    super.key,
    required this.hint,
    required this.prefixIcon, 
    this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    );

    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hint,
        // Добавляем вот эту строчку:
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(widget.prefixIcon, color: Colors.grey),

        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        
        suffixIcon: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              _isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey,
            ),
          ),
        ),

        // Применяем рамку
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder,
      ),
    );
  }
}
