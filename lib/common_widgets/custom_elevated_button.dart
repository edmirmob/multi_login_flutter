import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  CustomElevatedButton({
    Key key,
    this.child,
    this.color,
    this.borderRadius:2.0,
    this.height: 50.0,
    this.onPressed,
  }):assert(borderRadius != null), super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(borderRadius),
          ),
          primary: color,
        ),
        
        // ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      ),
    );
  }
}
