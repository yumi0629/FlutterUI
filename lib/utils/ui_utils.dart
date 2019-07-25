import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: axisDirection,
          color: Colors.transparent,
          showTrailing: false,
          showLeading: false,
          child: child,
        );
//        return child;
    }
    return null;
  }
}

class CustomCheckboxFormField extends FormField<bool> {
  CustomCheckboxFormField(FormFieldValidator<bool> validator)
      : super(
          initialValue: true,
          builder: (state) {
            return Checkbox(
              value: state.value,
              onChanged: (bool value) {
                state.didChange(value);
              },
            );
          },
          validator: validator,
        );

//  @override
//  // TODO: implement validator
//  get validator => super.validator;
}

void closeKeyboard() {
  SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
}

void openKeyboard() {
  SystemChannels.textInput.invokeMethod<void>('TextInput.show');
}

void popToFirst(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}
