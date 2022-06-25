// import 'package:flutter/material.dart';
// import 'package:whistle/size_config.dart';

// class FormError extends StatelessWidget {
//   const FormError({
//     required this.errors,
//   });

//   final List<String> errors;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: List.generate(
//             errors.length, (index) => formErrorText(error: errors[index])));
//   }

//   Row formErrorText({required String error}) {
//     return Row(
//       children: [
//         Icon(Icons.error, size: getProportionateScreenHeight(1)),
//         SizedBox(
//           width: getProportionateScreenWidth(10),
//         ),
//         Text(error),
//       ],
//     );
//   }
// }
