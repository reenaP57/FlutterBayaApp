import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField {
  InputDecoration appDecorationStyle(
      String hintText,
      String labelText,
      FontWeight hintFontWeight,
      FontWeight errorFontWeight,
      double hintFontSize,
      double errorFontSize,
      Color hintColor,
      Color errorMsgColor,
      double borderRadius) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      contentPadding: EdgeInsets.all(10),
      hintStyle: commonTextStyle(hintColor, hintFontSize, hintFontWeight),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      errorStyle:
          commonTextStyle(errorMsgColor, errorFontSize, errorFontWeight),
    );
  }

  TextStyle commonTextStyle(Color color, double fontSize, FontWeight fontWeight) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

// TextFormField appTextField(
//     TextEditingController controller,
//     String hintText,
//     String labelText,
//     FontWeight hintFontWeight,
//     FontWeight errorFontWeight,
//     double hintFontSize,
//     double errorFontSize,
//     Color hintColor,
//     Color errorMsgColor,
//     String validationMsg,
//     bool isCheckValidation,
//     double borderRadius,
//     TextInputType keyboardType) {
//
//   return  TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         hintText: hintText,
//         labelText: labelText,
//         hintStyle: commonTextStyle(hintColor, hintFontSize, hintFontWeight),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         errorStyle:
//             commonTextStyle(errorMsgColor, errorFontSize, errorFontWeight),
//       ),
//       // validator: (String value) {
//       //   if (isCheckValidation) {
//       //     if (value.isEmpty) {
//       //       return validationMsg;
//       //     }
//       //   }
//       // },
//   );
// }
}

