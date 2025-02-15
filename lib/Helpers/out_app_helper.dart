import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

mixin OutAppHelper on SnackBarHelper {
  Future<void> launchThisUrl(
    BuildContext context,
    String link, {
    LauncherType type = LauncherType.link,
  }) async {
    try {
      String _ = '';

      switch (type) {
        case LauncherType.link:
          _ = link;
          break;
        case LauncherType.mobile:
          _ = 'tel:$link';
          break;
        case LauncherType.email:
          _ = 'mailto:$link';
          break;
      }
      final Uri url = Uri.parse(_);

      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      showSnackBar(context, message: 'مشكلة في فتح الرابط', error: true);
    }
  }

  Future<void> shareThisUrl(String link, {String? subject}) async {
    await Share.share(link, subject: subject);
  }

  Future<void> shareThisFile(File file) async {
    List<XFile> files = [];
    XFile xFile = XFile(file.path);
    files.add(xFile);
    await Share.shareXFiles(files);
  }

  Future<String> getClipboardText() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }

  Future<void> openThisFile(BuildContext context, File file) async {
    try {
      var filepath = file.path;
      String ext = path.extension(filepath);
      var result = await OpenFile.open(filepath, );
      print('1');
      print(result.message);
      print(result.type.name);
      print('2');
      showSnackBar(
        context,
        message: result.message,
        error: result.type != ResultType.done,
      );
    } catch (e) {
      print('Open File Error => ${e.toString()}');
    }
  }
}
