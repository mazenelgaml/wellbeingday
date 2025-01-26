import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool isMultiline;
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.isMultiline = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Check validation status by running the validator
    // final isValid = validator == null || validator!(controller.text) == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff19649E),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            textAlign: TextAlign.right,
            maxLines: isMultiline ? 3 : 1,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                // borderSide: BorderSide(
                //   color: isValid
                //       ? Colors.grey
                //       : Colors.red, // Dynamic border color
                // ),
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(suffixIcon, color: const Color(0xff737373)),
                    )
                  : null,
              // errorText: validator != null ? validator!(controller.text) : null,
            ),
            validator: validator,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
