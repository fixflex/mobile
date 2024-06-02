class MessageModel {
  MessageModel({
    required this.messageId,
    required this.sender,
    required this.message,
    required this.chatId,
    required this.createdAt,
    required this.version,
  });

  final String messageId;
  final String sender;
  final String message;
  final String chatId;
  final DateTime createdAt;
  final int version;

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      messageId: jsonData['_id'],
      sender: jsonData['sender'],
      message: jsonData['message'],
      chatId: jsonData['chatId'],
      createdAt: DateTime.parse(jsonData['createdAt']),
      version: jsonData['__v'],
    );
  }
}