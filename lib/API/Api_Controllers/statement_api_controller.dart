import 'dart:convert';
import 'package:adam_group/API/api_helper.dart';
import 'package:adam_group/API/api_settings.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/accoun_statment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatementsApiController with SnackBarHelper, ApiHelper {
  Future<List<StatementModel>> getStatement(
      BuildContext context, String id) async {
    try {
      var url =
          Uri.parse(ApiSettings.getStatementById.replaceAll("{{id}}", id));
      var response = await http.get(url, headers: apiHeaders);
      print(response.body);
      var data = ListStatementModel.fromJson(jsonDecode(response.body));
      print('heeloooooo');
      return data.statements ?? [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
