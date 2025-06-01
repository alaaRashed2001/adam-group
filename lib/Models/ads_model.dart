class AdsListModel {
  List<AdsModel>? ads;

  AdsListModel({this.ads});

  AdsListModel.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = <AdsModel>[];
      json['ads'].forEach((v) {
        ads!.add( AdsModel.fromJson(v));
      });
    }
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


}