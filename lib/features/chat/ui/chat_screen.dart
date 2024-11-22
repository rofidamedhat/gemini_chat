import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_chat/core/helper/const.dart';
import 'package:gemini_chat/features/chat/data/service/chat_service.dart';
import 'package:gemini_chat/features/chat/logic/chat_cubit.dart';
import 'package:gemini_chat/features/chat/logic/chat_state.dart';
import 'package:gemini_chat/features/chat/ui/widgets/chat_message_list_view.dart';
import 'package:gemini_chat/features/chat/ui/widgets/send_message_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Gemini Chat',
          style: TextStyle(
              fontSize: 30,
              color: AppConst.primaryColor,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(ChatService()),
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return Column(
                children: [
                  ChatMessagesListView(
                    messages: context.read<ChatCubit>().messagesList,
                  ),
                  const SendMessageWidget()
                ],
              );
            },
          )),
    );
  }
}
