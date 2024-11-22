import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini_chat/core/helper/const.dart';
import 'package:gemini_chat/features/chat/data/model/message_model.dart';
import 'package:gemini_chat/features/chat/logic/chat_cubit.dart';
import 'package:gemini_chat/features/chat/logic/chat_state.dart';
import 'package:gemini_chat/features/chat/ui/widgets/build_content_message.dart';

class ChatMessagesListView extends StatelessWidget {
  const ChatMessagesListView({
    super.key,
    required this.messages,
  });
  final List<MessageModel> messages;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: context.read<ChatCubit>().scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          bool isMe = messages[index].isMessFromMe == true;
          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
                decoration: BoxDecoration(
                    color: isMe ? AppConst.primaryColor : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                      bottomLeft: Radius.circular(isMe ? 15.r : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 15.r),
                    )),
                child: isMe
                    ? BuildContentMessage(
                        message: messages[index], color: Colors.white)
                    : BlocBuilder<ChatCubit, ChatState>(
                        buildWhen: (previous, current) =>
                            current is ChatSuccess ||
                            current is ChatLoading ||
                            current is ChatFailure,
                        builder: (context, state) {
                          if (state is ChatLoading) {
                            return const SizedBox.shrink();
                            // SizedBox(
                            //   width: 50,
                            //   height: 30,
                            //   child: JumpingDots(
                            //     color: Colors.black,
                            //     radius: 6.r,
                            //     numberOfDots: 3,
                            //     animationDuration:
                            //         const Duration(milliseconds: 300),
                            //   ),
                            // );
                          } else if (state is ChatSuccess) {
                            return BuildContentMessage(
                                message: messages[index]);
                          } else if (state is ChatFailure) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          }
                          return BuildContentMessage(message: messages[index]);
                        },
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
