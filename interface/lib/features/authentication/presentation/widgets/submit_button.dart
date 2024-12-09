import 'package:flutter/material.dart';
import 'package:opennas/theme/theme.dart';

class SubmitButton extends StatefulWidget {
  final String text;
  final void Function() callback;
  const SubmitButton({
    super.key,
    required this.text,
    required this.callback,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: widget.callback,
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).custom.colorTheme.primary,
              borderRadius: BorderRadius.circular(0),
            ),
            // text input
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  widget.text,
                  style: Theme.of(context).custom.textTheme.bodyText1,
                ),
              ),
            )),
      ),
    );
  }
}
