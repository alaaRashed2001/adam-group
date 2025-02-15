import 'dart:convert';

import 'package:adam_group/API/api_helper.dart';
import 'package:adam_group/API/api_settings.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/containers_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContainerApiController with SnackBarHelper, ApiHelper {
  Future<List<ContainerModel>> getContainers(BuildContext context) async {
    try {
      var url = Uri.parse(ApiSettings.getContainersForHimself);
      var response = await http.get(url, headers: apiHeaders);
      List<dynamic> list = jsonDecode(response.body)['containers'];
      return ContainerModel.parseList(list);
    } catch (e) {
      return [];
    }
  }
}
