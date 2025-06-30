class StartChat {
  int? id;
  String? createdAt;
  OtherUser? otherUser;
  LastMessage? lastMessage;
  int? unreadCount;

  StartChat({
    this.id,
    this.createdAt,
    this.otherUser,
    this.lastMessage,
    this.unreadCount,
  });

  StartChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    otherUser = json['other_user'] != null
        ? OtherUser.fromJson(json['other_user'])
        : null;
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target_id'] = id;
    return data;
  }
}

class ChatList {
  int? id;
  String? createdAt;
  OtherUser? otherUser;
  LastMessage? lastMessage;
  int? unreadCount;

  ChatList({
    this.id,
    this.createdAt,
    this.otherUser,
    this.lastMessage,
    this.unreadCount,
  });

  ChatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    otherUser = json['other_user'] != null
        ? OtherUser.fromJson(json['other_user'])
        : null;
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    if (otherUser != null) {
      data['other_user'] = otherUser!.toJson();
    }
    if (lastMessage != null) {
      data['last_message'] = lastMessage!.toJson();
    }
    data['unread_count'] = unreadCount;
    return data;
  }
}

class OtherUser {
  int? id;
  String? name;
  String? type;
  String? image;

  OtherUser({this.id, this.name, this.type, this.image});

  OtherUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['image'] = image;
    return data;
  }
}

class LastMessage {
  String? content;
  String? timestamp;
  bool? isRead;
  String? senderId;

  LastMessage({
    this.content,
    this.timestamp,
    this.isRead,
    this.senderId,
  });

  LastMessage.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    timestamp = json['timestamp'];
    isRead = json['is_read'];
    senderId = json['sender_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['timestamp'] = timestamp;
    data['is_read'] = isRead;
    data['sender_id'] = senderId;
    return data;
  }
}

class SendChat {
  int? id;
  String? content;
  String? timestamp;
  bool? isRead;
  String? senderName;

  SendChat({
    this.id,
    this.content,
    this.timestamp,
    this.isRead,
    this.senderName,
  });

  SendChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    timestamp = json['timestamp'];
    isRead = json['is_read'];
    senderName = json['sender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_id'] = id;
    data['content'] = content;
    return data;
  }
}

class HistoryChat {
  int? id;
  String? content;
  String? timestamp;
  bool? isRead;
  String? senderName;

  HistoryChat({
    this.id,
    this.content,
    this.timestamp,
    this.isRead,
    this.senderName,
  });

  HistoryChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    timestamp = json['timestamp'];
    isRead = json['is_read'];
    senderName = json['sender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['timestamp'] = timestamp;
    data['is_read'] = isRead;
    data['sender_name'] = senderName;
    return data;
  }
}