class PlacesListModel {
  List<PlaceModel>? places;

  PlacesListModel({this.places});

  PlacesListModel.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      places = <PlaceModel>[];
      json['places'].forEach((v) {
        places!.add( PlaceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.places != null) {
      data['places'] = this.places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaceModel {
  int? id;
  String? name;
  String? imageName;
  String? imagePath;
  String? description;
  String? location;
  String? city;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? publicUrl;

  PlaceModel(
      {this.id,
        this.name,
        this.imageName,
        this.imagePath,
        this.description,
        this.location,
        this.city,
        this.country,
        this.createdAt,
        this.updatedAt,
        this.publicUrl});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
    description = json['description'];
    location = json['location_url'];
    city = json['city'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publicUrl = json['public_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_name'] = this.imageName;
    data['image_path'] = this.imagePath;
    data['description'] = this.description;
    data['location_url'] = this.location;
    data['city'] = this.city;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['public_url'] = this.publicUrl;
    return data;
  }
}