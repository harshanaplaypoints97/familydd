import 'package:flutter/cupertino.dart';

import '../../constant/App_color.dart';

Widget lableField(
  String labelName,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ],
  );
}

Widget titleField(
  String titlename,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        titlename,
        style: const TextStyle(
          fontFamily: 'inter',
          fontSize: 15.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
