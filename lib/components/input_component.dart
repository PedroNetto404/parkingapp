import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  final String label;
  final String placeholder;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool isHidden;

  const InputComponent({
    super.key,
    required this.label,
    required this.placeholder,
    this.prefixIcon,
    this.suffixIcon,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            obscureText: isHidden,
            decoration: InputDecoration(
              hintText: placeholder,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      );
}
