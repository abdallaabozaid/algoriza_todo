import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: 55.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(AppColors.appMainColor),
          overlayColor: MaterialStateProperty.all(
            Colors.black.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
