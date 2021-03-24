import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_login_flutter/common_widgets/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          height: 44,
          borderRadius: 4,
          color: Colors.indigo,
          onPressed: onPressed
        );
}
