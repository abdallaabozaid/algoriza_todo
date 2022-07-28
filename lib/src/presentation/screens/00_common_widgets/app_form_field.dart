import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo_app/src/presentation/common_widgets/spacers/vertical_spacer.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    required this.fieldTitle,
    required this.hintText,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);
  final String fieldTitle;
  final String hintText;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: textTheme.bodyMedium,
        ),
        VerticalSpacer(height: 8.h),
        SizedBox(
          height: 80.h,
          child: TextFormField(
            validator: validator,
            onChanged: onChanged,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme.bodySmall,
            ),
          ),
        ),
        VerticalSpacer(height: 6.h),
      ],
    );
  }
}
