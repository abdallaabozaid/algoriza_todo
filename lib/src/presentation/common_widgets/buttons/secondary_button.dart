// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:internship_tasks_06/config/constants/colors_const.dart';

// class SecondaryButton extends StatelessWidget {
//   const SecondaryButton({
//     Key? key,
//     required this.onPressed,
//     required this.label,
//     this.width = double.infinity,
//     this.height = 55,
//   }) : super(key: key);

//   final VoidCallback onPressed;
//   final Widget label;
//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width.w,
//       height: height.h,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         child: label,
//         style: ButtonStyle(
//           elevation: MaterialStateProperty.all(0),
//           backgroundColor: MaterialStateProperty.all(Colors.transparent),
//           foregroundColor: MaterialStateProperty.all(
//             Theme.of(context).colorScheme.onPrimary,
//           ),
//           side: MaterialStateProperty.all(
//             const BorderSide(
//               width: 1.4,
//               color: AppColors.appOnPrimaryColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
