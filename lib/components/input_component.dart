import 'package:flutter/material.dart';

class InputComponent extends StatefulWidget {
  final String label;
  final String placeholder;
  final Widget? prefix;
  final Widget? suffix;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;

  const InputComponent({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.validator,
    this.prefix,
    this.suffix,
    this.isPassword = false,
    this.keyboardType
  });

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            validator: widget.validator,
            obscureText: widget.isPassword && !showPassword,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintTextDirection: TextDirection.ltr,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon:
                  widget.isPassword ? const Icon(Icons.lock) : widget.prefix,
              suffixIcon: widget.isPassword ? _passwordSuffix() : widget.suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      );

  _passwordToggle() => setState(() => showPassword = !showPassword);

  _passwordSuffix() => IconButton(
        icon: Icon(
          showPassword ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: _passwordToggle,
      );
}
