class AdsListModel {
  List<AdsModel>? ads;

  AdsListModel({this.ads});

  AdsListModel.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = <AdsModel>[];
      json['ads'].forEach((v) {
        ads!.add(new AdsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ads != null) {
      data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdsModel {
  int? id;
  String? title;
  String? description;
  String? imagePath;
  String? imageName;
  int? isPublished;
  String? publicUrl;

  AdsModel(
      {this.id,
        this.title,
        this.description,
        this.imagePath,
        this.imageName,
        this.isPublished,
        this.publicUrl});

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    isPublished = json['is_published'];
    publicUrl = json['public_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image_path'] = this.imagePath;
    data['image_name'] = this.imageName;
    data['is_published'] = this.isPublished;
    data['public_url'] = this.publicUrl;
    return data;
  }
}