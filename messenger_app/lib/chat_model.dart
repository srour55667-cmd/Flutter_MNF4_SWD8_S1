class ChatModel {
  String? name;
  String? msg;
  int? id;
  String? img;
  String? createdAt;
  MessageType? msgType;

  ChatModel({
    this.name,
    this.msg,
    this.id,
    this.msgType,
    this.createdAt,
    this.img,
  });

  ChatModel.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    msg = json["msg"];
    img = json["img"];
    msgType =getMessageType((json["message_type"]));
    createdAt = json["createdAt"];
  }
}

enum MessageType { VIDEO, GIF, TEXT }

MessageType? getMessageType(String msgType) {
  switch (msgType) {
    case "video":
      return MessageType.VIDEO;
    case "gif":
      return MessageType.GIF;
    case "text":
      return MessageType.TEXT;
  }
}
