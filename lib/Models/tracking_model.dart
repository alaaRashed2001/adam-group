// // models/tracking_model.dart
//
// class TrackingResponse {
//   final String status;
//   final String message;
//   final TrackingData data;
//
//   TrackingResponse({required this.status, required this.message, required this.data});
//
//   factory TrackingResponse.fromJson(Map<String, dynamic> json) {
//     return TrackingResponse(
//       status: json['status'],
//       message: json['message'],
//       data: TrackingData.fromJson(json['data']),
//     );
//   }
// }
//
// class TrackingData {
//   final Metadata metadata;
//   final List<Location> locations;
//   final List<Container> containers;
//
//   TrackingData({
//     required this.metadata,
//     required this.locations,
//     required this.containers,
//   });
//
//   factory TrackingData.fromJson(Map<String, dynamic> json) {
//     return TrackingData(
//       metadata: Metadata.fromJson(json['metadata']),
//       locations: (json['locations'] as List)
//           .map((e) => Location.fromJson(e))
//           .toList(),
//       containers: (json['containers'] as List)
//           .map((e) => Container.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class Metadata {
//   final String number;
//   final String status;
//   final bool isStatusFromSealine;
//
//   Metadata({
//     required this.number,
//     required this.status,
//     required this.isStatusFromSealine,
//   });
//
//   factory Metadata.fromJson(Map<String, dynamic> json) {
//     return Metadata(
//       number: json['number'],
//       status: json['status'],
//       isStatusFromSealine: json['is_status_from_sealine'],
//     );
//   }
// }
//
// class Location {
//   final String name;
//   final String country;
//   final double lat;
//   final double lng;
//
//   Location({
//     required this.name,
//     required this.country,
//     required this.lat,
//     required this.lng,
//   });
//
//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       name: json['name'],
//       country: json['country'],
//       lat: json['lat'].toDouble(),
//       lng: json['lng'].toDouble(),
//     );
//   }
// }
//
// class Container {
//   final String number;
//   final String status;
//   final List<ContainerEvent> events;
//
//   Container({
//     required this.number,
//     required this.status,
//     required this.events,
//   });
//
//   factory Container.fromJson(Map<String, dynamic> json) {
//     return Container(
//       number: json['number'],
//       status: json['status'],
//       events: (json['events'] as List)
//           .map((e) => ContainerEvent.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class ContainerEvent {
//   final String description;
//   final String date;
//   final int location;
//
//   ContainerEvent({
//     required this.description,
//     required this.date,
//     required this.location,
//   });
//
//   factory ContainerEvent.fromJson(Map<String, dynamic> json) {
//     return ContainerEvent(
//       description: json['description'],
//       date: json['date'],
//       location: json['location'],
//     );
//   }
// }

class TrackingResponse {
  final TrackingData data;

  TrackingResponse({required this.data});

  factory TrackingResponse.fromJson(Map<String, dynamic> json) {
    return TrackingResponse(
      data: TrackingData.fromJson(json['data']),
    );
  }
}

class TrackingData {
  final Metadata metadata;
  final List<Location> locations;
  final RouteInfo route;
  final List<ContainerData> containers;

  TrackingData({
    required this.metadata,
    required this.locations,
    required this.route,
    required this.containers,
  });

  factory TrackingData.fromJson(Map<String, dynamic> json) {
    return TrackingData(
      metadata: Metadata.fromJson(json['metadata']),
      locations: (json['locations'] as List)
          .map((e) => Location.fromJson(e))
          .toList(),
      route: RouteInfo.fromJson(json['route']),
      containers: (json['containers'] as List)
          .map((e) => ContainerData.fromJson(e))
          .toList(),
    );
  }
}

class Metadata {
  final String number;
  final String sealineName;
  final String status;

  Metadata({
    required this.number,
    required this.sealineName,
    required this.status,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      number: json['number'],
      sealineName: json['sealine_name'],
      status: json['status'],
    );
  }
}

class Location {
  final int id;
  final String name;
  final double lat;
  final double lng;

  Location({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }
}

class RouteInfo {
  final RoutePoint prepol;
  final RoutePoint pol;
  final RoutePoint pod;
  final RoutePoint postpod;

  RouteInfo({
    required this.prepol,
    required this.pol,
    required this.pod,
    required this.postpod,
  });

  factory RouteInfo.fromJson(Map<String, dynamic> json) {
    return RouteInfo(
      prepol: RoutePoint.fromJson(json['prepol']),
      pol: RoutePoint.fromJson(json['pol']),
      pod: RoutePoint.fromJson(json['pod']),
      postpod: RoutePoint.fromJson(json['postpod']),
    );
  }
}

class RoutePoint {
  final int location;
  final String date;

  RoutePoint({
    required this.location,
    required this.date,
  });

  factory RoutePoint.fromJson(Map<String, dynamic> json) {
    return RoutePoint(
      location: json['location'],
      date: json['date'],
    );
  }
}

class ContainerData {
  final String number;
  final String status;
  final List<ShipmentEvent> events;

  ContainerData({
    required this.number,
    required this.status,
    required this.events,
  });

  factory ContainerData.fromJson(Map<String, dynamic> json) {
    return ContainerData(
      number: json['number'],
      status: json['status'],
      events: (json['events'] as List)
          .map((e) => ShipmentEvent.fromJson(e))
          .toList(),
    );
  }
}

class ShipmentEvent {
  final String description;
  final String date;
  final int location;
  final double? lat;
  final double? lng;

  ShipmentEvent({
    required this.description,
    required this.date,
    required this.location,
    this.lat,
    this.lng,
  });

  factory ShipmentEvent.fromJson(Map<String, dynamic> json) {
    return ShipmentEvent(
      description: json['description'],
      date: json['date'],
      location: json['location'],
    );
  }
}
