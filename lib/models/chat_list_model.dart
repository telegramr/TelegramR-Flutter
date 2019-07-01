class ChatListT {
  final int id;
  final String uname;
  final String avatar;
  final Map message;
  final int date;
  final int unread;
  final String type;

  ChatListT(
      {this.id,
      this.uname,
      this.avatar,
      this.message,
      this.date,
      this.unread,
      this.type});

  factory ChatListT.fromJson(Map<String, dynamic> json) {
    return ChatListT(
      id: json['rank'] as int,
      uname: json['uname'] as String,
      avatar: json['avatar'] as String,
      message: json['message'] as Map,
      date: json['date'] as int,
      unread: json['unread'] as int,
      type: json['type'] as String,
    );
  }
}
