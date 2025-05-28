class ContainerModel {
  final int id;
  final String? fileName;
  final String? filePath;
  final int? type;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final String? publicUrl;

  ContainerModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.type,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.publicUrl,
  });

  // تحويل JSON إلى كائن Dart
  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      id: json['id'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      type: json['type'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      publicUrl: json['public_url'],
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'file_path': filePath,
      'type': type,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'public_url': publicUrl,
    };
  }

  // تحويل List من JSON لـ List من كائنات ContainerModel
  static List<ContainerModel> parseList(List<dynamic> jsonList) {
    return jsonList.map((json) => ContainerModel.fromJson(json)).toList();
  }
}

