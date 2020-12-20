import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  const BarButton({Key key, this.label, this.decoration, this.onTap})
      : super(key: key);

  final String label;
  final BoxDecoration decoration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: decoration,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
