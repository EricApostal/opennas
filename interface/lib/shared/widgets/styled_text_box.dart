import 'package:flutter/material.dart';
import 'package:opennas/theme/theme.dart';

class StyledTextBox extends StatelessWidget {
  final String defaultText;
  final TextEditingController controller;
  final bool? obscureText;

  const StyledTextBox({
    super.key,
    required this.defaultText,
    required this.controller,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).custom.colorTheme.foreground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).custom.colorTheme.tertiary,
          width: 1,
        ),
      ),
      // text input
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: defaultText,
          hintStyle: Theme.of(context).custom.textTheme.bodyText2,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
