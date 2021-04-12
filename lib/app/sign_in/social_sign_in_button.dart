import 'package:flutter/material.dart';
import 'package:multi_login_flutter/common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    @required String assetImage,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) :  assert(text !=null),
 super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(assetImage),
                Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 15),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(
                    assetImage,
                  ),
                ),
              ],
            ),
            color: color,
            onPressed: onPressed);
}
