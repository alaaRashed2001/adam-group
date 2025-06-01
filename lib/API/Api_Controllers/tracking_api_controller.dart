import 'dart:convert';
import 'package:adam_group/API/api_settings.dart';
import 'package:adam_group/Models/tracking_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrackingApiController {
  Future<TrackingResponse?> getTracking(BuildContext context, String number) async {
    try {
      var url = Uri.parse(ApiSettings.getTracking.replaceAll("{{number}}", number));
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return TrackingResponse.fromJson(jsonData);
      }
    } catch (e) {
      debugPrint('❌ Error fetching tracking: $e');
    }
    return null;
  }
}

