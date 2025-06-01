class ContainerModel {
  final int id;
  final String? fileName;
  final String? filePath;
  final int? isDelevired;
  final String? deliveryDate;
  final String? trackingNumber;
  final int? type;
  final int? userId;
  final String? publicUrl;

  ContainerModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.isDelevired,
    required this.deliveryDate,
    required this.trackingNumber,
    required this.type,
    required this.userId,
    required this.publicUrl,
  });

  // تحويل JSON إلى كائن Dart
  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      id: json['id'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      isDelevired: json['is_delevired'],
      deliveryDate: json['delivery_date'],
      trackingNumber: json['tracking_number'],
      type: json['type'],
      userId: json['user_id'],
      publicUrl: json['public_url'],
    );
  }



  // تحويل List من JSON لـ List من كائنات ContainerModel
  static List<ContainerModel> parseList(List<dynamic> jsonList) {
    return jsonList.map((json) => ContainerModel.fromJson(json)).toList();
  }
}
