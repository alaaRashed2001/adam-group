import 'dart:convert';
import 'package:adam_group/API/api_helper.dart';
import 'package:adam_group/API/api_settings.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/ads_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdsApiController with SnackBarHelper, ApiHelper {
  Future<List<AdsModel>> getAds(BuildContext context) async {
    try {
      var url = Uri.parse(ApiSettings.getAds);
      var response = await http.get(url, headers: apiHeaders);
      var data = AdsListModel.fromJson(jsonDecode(response.body));
      return data.ads ?? [];
    } catch (e) {
      return [];
    }
  }
}
