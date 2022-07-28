import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/domain/00_core/value_fauilure.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    required this.failure,
  }) : super(key: key);

  final ValueFailure failure;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: 20.h,
      child: Text(
        failure.failedValue,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.red,
        ),
      ),
    );
  }
}
