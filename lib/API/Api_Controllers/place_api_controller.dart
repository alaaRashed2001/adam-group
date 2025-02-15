import 'dart:convert';

import 'package:adam_group/API/api_helper.dart';
import 'package:adam_group/API/api_settings.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/places_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceApiController with SnackBarHelper, ApiHelper {
  Future<List<PlaceModel>> getPlaces(BuildContext context) async {
    try {
      var url = Uri.parse(ApiSettings.getPlaces);
      var response = await http.get(url, headers: apiHeaders);
      var data = PlacesListModel.fromJson(jsonDecode(response.body));
      return data.places ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<PlaceModel?> getPlaceById(BuildContext context, String id) async {
    try {
      var url = Uri.parse(ApiSettings.getPlacesById.replaceAll('{id}', id));
      var response = await http.get(url, headers: apiHeaders);
      return  PlaceModel.fromJson(jsonDecode(response.body)['place']);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}
