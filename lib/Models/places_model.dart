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

}