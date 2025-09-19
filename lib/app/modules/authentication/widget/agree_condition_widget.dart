import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';

class AgreeConditionCheck extends StatefulWidget {
  const AgreeConditionCheck({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<AgreeConditionCheck> createState() => _AgreeConditionCheckState();
}

class _AgreeConditionCheckState extends State<AgreeConditionCheck> {
  bool isChecked = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
            widget.onChanged(isChecked); // notify parent
          },
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'By agreeing to the ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigator.pushNamed(context, InfoScreen.routeName,
                      //     arguments: {
                      //       'appBarTitle': 'Terms & Conditions',
                      //       'data':
                      //           '${controller.contentlist?[0].termsAndConditions}'
                      //     });
                    },
                  text: 'Terms & Conditions ',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.greenColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
