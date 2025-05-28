import 'dart:convert';
import 'package:adam_group/API/api_helper.dart';
import 'package:adam_group/API/api_settings.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationApiController with SnackBarHelper, ApiHelper {
  Future<List<NotificationModel>> getNotifications() async {
    try {
      var url = Uri.parse(ApiSettings.getNotifications);
      final response = await http.get(
        url,
        headers: apiHeaders,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NotificationModel.parseList(jsonData['notifications']);
      } else {
        throw Exception(
            'Failed to load notifications: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }
}
