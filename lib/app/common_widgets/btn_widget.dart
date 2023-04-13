import 'package:flutter/material.dart';

class ButttonCustom extends StatelessWidget {
  const ButttonCustom({
    Key? key,
    required this.onTap,
    required this.label,
    required this.fontSize,
    required this.height,
    this.color = Colors.orange,
  }) : super(key: key);
  final GestureTapCallback? onTap;
  final String label;
  final double fontSize;
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: Text(label, style: TextStyle(fontSize: fontSize)),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    side: BorderSide(color: color)))),
        onPressed: onTap,
      ),
    );
  }
}
