import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_chat/core/bloc_observer.dart';
import 'package:gemini_chat/gemini_chat.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const GeminiChat());
}
