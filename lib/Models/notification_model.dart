class NotificationModel {
  int? id;
  int? userId;
  String? title;
  String? body;
  int? isRead;
  dynamic data;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.isRead,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      body: json['body'],
      isRead: json['is_read'],
      data: json['data'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  static List<NotificationModel> parseList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
  }
}


