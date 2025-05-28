class ListStatementModel {
  List<StatementModel>? statements;

  ListStatementModel({this.statements});

  ListStatementModel.fromJson(Map<String, dynamic> json) {
    if (json['account_statments'] != null) {
      statements = <StatementModel>[];
      json['account_statments'].forEach((v) {
        statements!.add(StatementModel.fromJson(v));
      });
    }
  }


}

class StatementModel {
  int? id;
  String? fileName;
  String? filePath;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? publicUrl;

  StatementModel();

  StatementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publicUrl = json['public_url'];
  }

}