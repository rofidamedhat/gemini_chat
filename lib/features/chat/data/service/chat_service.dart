import 'dart:developer';
import 'dart:io';

import 'package:gemini_chat/core/helper/const.dart';
import 'package:gemini_chat/features/chat/data/model/message_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mime/mime.dart';

class ChatService {
  final _model =
      GenerativeModel(model: 'gemini-1.5-flash', apiKey: AppConst.apiKey);

  Future<MessageModel> sendMessage(MessageModel messageModel) async {
    if (messageModel.image != null) {
      return await generateTextAndFileImageContent(messageModel);
    } else {
      return await generateTextContext(messageModel);
    }
  }

  Future<MessageModel> generateTextContext(MessageModel messageModel) async {
    try {
      final response = await _model.generateContent(
          [Content.text(messageModel.text ?? 'No message provided')]);
      return MessageModel(text: response.text, isMessFromMe: false);
    } catch (e) {
      log('error in text gen func ${e.toString()}');
      return MessageModel(
          text: 'Error Because ${e.toString()}', isMessFromMe: false);
    }
  }

  handeImageAsDataPart(String imagePath) async {
    final mimeType = lookupMimeType(imagePath);
    final image = DataPart(mimeType!, await File(imagePath).readAsBytes());
    return image;
  }

  Future<MessageModel> generateTextAndFileImageContent(
      MessageModel messageModel) async {
    try {
      final image = await handeImageAsDataPart(messageModel.image!);
      final response = await _model.generateContent([
        Content.multi([
          TextPart(messageModel.text!),
          image,
        ])
      ]);
      return MessageModel(
          text: response.text, isMessFromMe: false, image: messageModel.image);
    } catch (e) {
      log('error in text &Img gen func ${e.toString()}');
      return MessageModel(
          text: 'Error Because ${e.toString()}', isMessFromMe: false);
    }
  }
}
