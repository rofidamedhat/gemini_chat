class MessageModel {
  final String? text;
  String? image;
  final bool isMessFromMe;
  //  bool isLoading;

  MessageModel({
    this.text,
    this.image,
    this.isMessFromMe = true,
    // this.isLoading = false,
  });
  // copyWith({
  //   String? text,
  //   String? image,
  //   bool? isMessFromMe,
  //   bool? isLoading,
  // }) {
  //   return MessageModel(
  //     text: text ?? this.text,
  //     image: image ?? this.image,
  //     isMessFromMe: isMessFromMe ?? this.isMessFromMe,
  //     // isLoading: isLoading ?? this.isLoading,
  //   );
  // }
}
