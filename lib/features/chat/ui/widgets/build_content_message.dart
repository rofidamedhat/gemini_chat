import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini_chat/features/chat/data/model/message_model.dart';

class BuildContentMessage extends StatelessWidget {
  const BuildContentMessage({
    super.key,
    required this.message,
    this.color = Colors.black,
  });
  final MessageModel message;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (message.image != null)
        SizedBox(
            height: 180.h,
            width: 180.w,
            child: Image.file(File(message.image!), fit: BoxFit.cover)),
      if (message.text != null)
        Text(
          message.text!,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.w500),
        )
    ]);
  }
}
