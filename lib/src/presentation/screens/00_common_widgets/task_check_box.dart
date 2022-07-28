import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskCheckBox extends StatelessWidget {
  const TaskCheckBox({
    Key? key,
    this.color,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final Color? color;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            width: 0.5,
            color: Colors.white,
          )),
      child: Checkbox(
        visualDensity: VisualDensity.compact,
        fillColor: MaterialStateProperty.all(color ?? Colors.transparent),
        checkColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
