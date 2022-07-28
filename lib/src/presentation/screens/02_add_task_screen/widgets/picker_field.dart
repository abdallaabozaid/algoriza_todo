import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo_app/src/presentation/common_widgets/spacers/vertical_spacer.dart';

class PickerField extends StatelessWidget {
  const PickerField({
    Key? key,
    this.width = double.infinity,
    required this.fieldTitle,
    required this.fieldHintText,
    required this.icon,
    required this.showError,
    this.height = 75,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final String fieldTitle;
  final String fieldHintText;
  final IconData icon;
  final bool showError;
  final double height;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          VerticalSpacer(height: 8.h),
          SizedBox(
            height: height.h,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                alignment: Alignment.center,
                width: width,
                height: 55.h,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      color: showError ? Colors.red : Colors.transparent,
                      width: 0.8,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fieldHintText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(icon),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
