sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {}

final class ChatFailure extends ChatState {}

final class ChatImageSelectedState extends ChatState {}

final class ChatImageClearedState extends ChatState {}
