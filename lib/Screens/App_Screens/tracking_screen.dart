import 'package:adam_group/Models/tracking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math';

class TrackingDetailsScreen extends StatelessWidget {
  final TrackingResponse response;

  const TrackingDetailsScreen({super.key, required this.response});

  List<LatLng> _createArcPoints(LatLng start, LatLng end, {int segments = 20}) {
    final points = <LatLng>[];

    if (start.latitude == end.latitude && start.longitude == end.longitude) {
      points.add(start);
      return points;
    }

    final lat1 = start.latitude * pi / 180;
    final lon1 = start.longitude * pi / 180;
    final lat2 = end.latitude * pi / 180;
    final lon2 = end.longitude * pi / 180;

    final d = 2 *
        asin(sqrt(pow(sin((lat1 - lat2) / 2), 2) +
            cos(lat1) * cos(lat2) * pow(sin((lon1 - lon2) / 2), 2)));

    if (d < 0.0001) {
      points.add(start);
      points.add(end);
      return points;
    }

    for (var i = 0; i <= segments; i++) {
      final t = i / segments;
      final f = sin((1 - t) * d) / sin(d);
      final g = sin(t * d) / sin(d);

      final x = f * cos(lat1) * cos(lon1) + g * cos(lat2) * cos(lon2);
      final y = f * cos(lat1) * sin(lon1) + g * cos(lat2) * sin(lon2);
      final z = f * sin(lat1) + g * sin(lat2);

      final lat = atan2(z, sqrt(x * x + y * y));
      final lon = atan2(y, x);

      points.add(LatLng(lat * 180 / pi, lon * 180 / pi));
    }

    return points;
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              fontFamily: "almaraiFonts",
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "almaraiFonts",
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meta = response.data.metadata;
    final container = response.data.containers.first;
    final locations = response.data.locations;

    final curvedPolylines = <Polyline>[];
    final allArcPoints = <LatLng>[];

    for (int i = 0; i < container.events.length - 1; i++) {
      final e1 = container.events[i];
      final e2 = container.events[i + 1];
      final loc1 = locations.firstWhere((l) => l.id == e1.location);
      final loc2 = locations.firstWhere((l) => l.id == e2.location);

      final start = LatLng(loc1.lat, loc1.lng);
      final end = LatLng(loc2.lat, loc2.lng);

      final arcPoints = _createArcPoints(start, end, segments: 30);
      allArcPoints.addAll(arcPoints);

      curvedPolylines.add(
        Polyline(
          points: arcPoints,
          strokeWidth: 4.0,
          color: Colors.blueAccent,
        ),
      );
    }

    final eventMarkers = container.events.map((e) {
      final loc = locations.firstWhere((l) => l.id == e.location);
      return Marker(
        point: LatLng(loc.lat, loc.lng),
        width: 40,
        height: 40,
        child: const Icon(Icons.location_on, color: Colors.red, size: 30),
      );
    }).toList();

    final avgLat =
        locations.map((l) => l.lat).reduce((a, b) => a + b) / locations.length;
    final avgLng =
        locations.map((l) => l.lng).reduce((a, b) => a + b) / locations.length;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('${AppLocalizations.of(context)!.tracking}: ${meta.number}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // معلومات الشحنة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow(AppLocalizations.of(context)!.shipmentStatus,
                          meta.status),
                      _infoRow(AppLocalizations.of(context)!.containersCount,
                          response.data.containers.length.toString()),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: FlutterMap(
                mapController: MapController(),
                options: MapOptions(
                  initialCenter: LatLng(avgLat, avgLng),
                  initialZoom: 2,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  PolylineLayer(polylines: curvedPolylines),
                  MarkerLayer(markers: eventMarkers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
