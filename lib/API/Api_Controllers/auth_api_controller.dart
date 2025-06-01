import 'dart:convert';
import 'package:adam_group/API/api_helper.dart';
import 'package:adam_group/API/api_settings.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/status_message_model.dart';
import 'package:adam_group/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthApiController with SnackBarHelper, ApiHelper {
  Future<LoginResponseModel?> login(
      BuildContext context, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSettings.login),
        headers: apiHeaders,
        body: json.encode({'phone': phone, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginResponseModel.fromJson(data);
      } else {
        handleErrors(context, jsonDecode(response.body));
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<bool> changePassword(
    BuildContext context,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse(ApiSettings.changePassword),
        headers: apiHeaders,
        body: json.encode({
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = StatusMessageModel.fromJson(jsonDecode(response.body));
        showSnackBar(context, message: data.message ?? '', error: false);
        return true;
      } else if (response.statusCode == 400) {
        final data = StatusMessageModel.fromJson(jsonDecode(response.body));
        showSnackBar(context, message: data.message ?? '', error: true);
        return false;
      } else {
        handleErrors(context, jsonDecode(response.body));
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> changeMobile(
    BuildContext context,
    String newMobile,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse(ApiSettings.changeMobileNumber),
        headers: apiHeaders,
        body: json.encode({
          'phone': newMobile,
        }),
      );

      if (response.statusCode == 200) {
        final data = StatusMessageModel.fromJson(jsonDecode(response.body));
        showSnackBar(context, message: data.message ?? '', error: false);
        return true;
      } else {
        handleErrors(context, jsonDecode(response.body));
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> updateUserInfo(
    BuildContext context,
    String newName,
    String newPhone,
    String newEmail,
    String newPassword,
  ) async {
    try {
      final response = await http.put(
        Uri.parse(ApiSettings.updateInfo),
        headers: apiHeaders,
        body: json.encode({
          'name': newName,
          'email': newEmail,
          'password': newPassword,
          'phone': newPhone,
        }),
      );
      if (response.statusCode == 200) {
        final data = StatusMessageModel.fromJson(jsonDecode(response.body));
        showSnackBar(context, message: data.message ?? '', error: false);
        return true;
      } else {
        handleErrors(context, jsonDecode(response.body));
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final response = await http.post(
        Uri.parse(ApiSettings.logout),
        headers: apiHeaders,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> deleteAccount(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(ApiSettings.deleteAccount.replaceAll('{{id}}', id)),
        headers: apiHeaders,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<void> saveFcm(BuildContext context, String? fcm) async {
    try {
      await http.post(
        Uri.parse(ApiSettings.userToken),
        headers: apiHeaders,
        body: json.encode({'device_token': fcm}),
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}
