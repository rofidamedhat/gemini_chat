import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini_chat/core/helper/const.dart';
import 'package:gemini_chat/core/helper/spacing.dart';
import 'package:gemini_chat/features/chat/logic/chat_cubit.dart';
import 'package:gemini_chat/features/chat/logic/chat_state.dart';
import 'package:gemini_chat/features/chat/ui/widgets/custom_text_field.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.read<ChatCubit>().imagePath != null)
                Stack(alignment: Alignment.topRight, children: [
                  Container(
                      width: 280.w,
                      height: 140.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[300]),
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Image.file(
                          File(context.read<ChatCubit>().imagePath!),
                          height: 150.h,
                          width: 150.w,
                          fit: BoxFit.contain)),
                  IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => context.read<ChatCubit>().clearImage())
                ]),
              Row(
                children: [
                  Expanded(
                    child: Form(
                        key: context.read<ChatCubit>().formKey,
                        child: CustomTextField(
                          controller: context.read<ChatCubit>().inputController,
                          hintText: 'Enter Your Message...',
                        )),
                  ),
                  horizontalSpace(10),
                  GestureDetector(
                    onTap: () async {
                      context.read<ChatCubit>().imagePath =
                          await context.read<ChatCubit>().openGallery();
                      // if (context.read<ChatCubit>().imagePath != null) {
                      //   log('Image selected: ${context.read<ChatCubit>().imagePath}');
                      // }
                    },
                    child: const Icon(Icons.image,
                        color: AppConst.primaryColor, size: 28),
                  ),
                  horizontalSpace(10),
                  GestureDetector(
                      onTap: () {
                        if (context
                            .read<ChatCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<ChatCubit>().sendMessage();
                        } else {
                          log('Form is not valid');
                        }
                      },
                      child: const Icon(Icons.send,
                          color: AppConst.primaryColor, size: 28))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
