class MessageT {
  final int id;
  final int from_id;
  final int to_id;
  final bool out;
  final String uname;
  final String avatar;
  final Map message;
  final int date;
  final String type;

  MessageT(
      {this.id,
      this.from_id,
      this.to_id,
      this.out,
      this.uname,
      this.avatar,
      this.message,
      this.date,
      this.type});

  factory MessageT.fromJson(Map<String, dynamic> json) {
    return MessageT(
      id: json['rank'] as int,
      from_id: json['from_id'] as int,
      to_id: json['to_id'] as int,
      out: json['out'] as bool,
      uname: json['uname'] as String,
      avatar: json['avatar'] as String,
      message: json['message'] as Map,
      date: json['date'] as int,
      type: json['type'] as String,
    );
  }
}
