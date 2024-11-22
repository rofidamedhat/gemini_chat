import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_chat/features/chat/data/model/message_model.dart';
import 'package:gemini_chat/features/chat/data/service/chat_service.dart';
import 'package:gemini_chat/features/chat/logic/chat_state.dart';
import 'package:image_picker/image_picker.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatService) : super(ChatInitial());
  final ChatService chatService;

  final formKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<MessageModel> messagesList = [];
  String? imagePath;

  void scrollToBottom() {
    if (scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
  }

  MessageModel sendMessageFromMe() {
    final userMessage = MessageModel(
      text: inputController.text,
      isMessFromMe: true,
      image: imagePath,
    );
    messagesList.add(userMessage);
    scrollToBottom();
    inputController.clear();
    clearImage(); // imagePath = null;
    return userMessage;
  }

  Future<void> sendMessage() async {
    try {
      final userMessage = sendMessageFromMe();
      emit(ChatLoading());

      final codeGen = await chatService.sendMessage(userMessage);
      messagesList.add(codeGen);
      log(messagesList.toString());
      scrollToBottom();
      emit(ChatSuccess());
      // messagesList.forEach((messageModel) => messageModel.isLoading = false);
    } catch (e) {
      log(e.toString());
      emit(ChatFailure());
    }
  }

  Future<String?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      emit(ChatImageSelectedState());
      return photo.path;
    } else {
      return null;
    }
  }

  void clearImage() {
    imagePath = null;
    emit(ChatImageClearedState());
  }
}
