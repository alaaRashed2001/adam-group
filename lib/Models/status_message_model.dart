class StatusMessageModel {
  bool? status;
  String? message;

  StatusMessageModel(this.status, this.message);

  StatusMessageModel.fromJson(Map<String, dynamic> map) {
    status = map['status'];
    message = map['message'];
  }
}
