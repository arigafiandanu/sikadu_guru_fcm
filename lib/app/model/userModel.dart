class ChatUser {
  ChatUser({
    this.connection,
    this.chatId,
    this.lastTime,
    this.total_unread,
  });

  String? connection;
  String? chatId;
  String? lastTime;
  int? total_unread;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        connection: json["connection"],
        chatId: json["chat_id"],
        lastTime: json["lastTime"],
        total_unread: json["total_unread"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "chat_id": chatId,
        "lastTime": lastTime,
        "total_unread": total_unread,
      };
}

class UserData {
  String? id;
  String? nama;
  String? noTelp;
  String? foto;
  String? alamat;
  String? role;
  String? email;
  String? creationTime;

  UserData({
    this.id,
    this.nama,
    this.noTelp,
    this.foto,
    this.alamat,
    this.role,
    this.email,
    this.creationTime,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    UserData(
      id: json['id'],
      nama: json['nama'],
      noTelp: json['noTelp'],
      foto: json['foto'],
      alamat: json['alamat'],
      role: json['role'],
      email: json['email'],
      creationTime: json['creationTime'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "noTelp": noTelp,
      "foto": foto,
      "alamat": alamat,
      "role": role,
      "email": email,
      "creationTime": creationTime,
    };
  }
}
