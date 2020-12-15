class UserModel {
  UserModel({
    this.userId,
    this.address,
    this.country,
    this.createDate,
    this.defaultContactNumber,
    this.delStatus,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.phoneNo,
    this.profilePic,
    this.pushNotification,
    this.role,
    this.smsNotification,
  });

  UserId userId;
  String address;
  String country;
  CreateDate createDate;
  String defaultContactNumber;
  bool delStatus;
  String email;
  String firstName;
  String lastName;
  String password;
  String phoneNo;
  String profilePic;
  UserNotification pushNotification;
  List<String> role;
  UserNotification smsNotification;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: UserId.fromJson(json["_id"]),
    address: json["address"],
    country: json["country"],
    createDate: CreateDate.fromJson(json["create_date"]),
    defaultContactNumber: json["default_contact_number"],
    delStatus: json["del_status"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    password: json["password"],
    phoneNo: json["phone_no"],
    profilePic: json["profile_pic"],
    pushNotification: UserNotification.fromJson(json["pushNotification"]),
    role: List<String>.from(json["role"].map((x) => x)),
    smsNotification: UserNotification.fromJson(json["smsNotification"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": userId.toJson(),
    "address": address,
    "country": country,
    "create_date": createDate.toJson(),
    "default_contact_number": defaultContactNumber,
    "del_status": delStatus,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "password": password,
    "phone_no": phoneNo,
    "profile_pic": profilePic,
    "pushNotification": pushNotification.toJson(),
    "role": List<dynamic>.from(role.map((x) => x)),
    "smsNotification": smsNotification.toJson(),
  };
}

class CreateDate {
  CreateDate({
    this.date,
  });

  DateTime date;

  factory CreateDate.fromJson(Map<String, dynamic> json) => CreateDate(
    date: DateTime.fromMillisecondsSinceEpoch(json["\u0024date"]),
  );

  Map<String, dynamic> toJson() => {
    "\u0024date": date,
  };
}

class UserId {
  UserId({
    this.oid,
  });

  String oid;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    oid: json["\u0024oid"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024oid": oid,
  };
}

class UserNotification {
  UserNotification({
    this.onBooking,
    this.onMessageSend,
    this.onSuppportReply,
  });

  bool onBooking;
  bool onMessageSend;
  bool onSuppportReply;

  factory UserNotification.fromJson(Map<String, dynamic> json) => UserNotification(
    onBooking: json["on_booking"],
    onMessageSend: json["on_message_send"],
    onSuppportReply: json["on_suppport_reply"],
  );

  Map<String, dynamic> toJson() => {
    "on_booking": onBooking,
    "on_message_send": onMessageSend,
    "on_suppport_reply": onSuppportReply,
  };
}
