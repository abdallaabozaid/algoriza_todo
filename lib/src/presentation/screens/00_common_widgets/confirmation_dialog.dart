import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/theme/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmLabel,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);
  final String title;
  final String content;
  final String confirmLabel;

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        _action(
          onCancel,
          'Cancel',
          primary: AppColors.appMainColor,
          onPrimary: Colors.white,
        ),
        _action(
          onConfirm,
          confirmLabel,
          onPrimary: Colors.black,
          primary: Colors.grey.shade200,
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: _title(),
      buttonPadding: EdgeInsets.all(20.h),
      elevation: 5,
      actionsAlignment: MainAxisAlignment.spaceAround,
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _action(
    VoidCallback onPressed,
    String label, {
    Color? primary,
    Color? onPrimary,
  }) {
    return SizedBox(
      height: 42.h,
      width: 90.w,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
        ),
        style: ElevatedButton.styleFrom(
            primary: primary,
            onPrimary: onPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r))),
      ),
    );
  }

  Container _title() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.appMainColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
