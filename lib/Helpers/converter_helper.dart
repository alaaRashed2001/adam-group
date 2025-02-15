import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

mixin ConverterHelper {
  Future<File> convertLinkToFile(String link) async {
    /// 1
    var url = Uri.parse(link);
    var response = await http.get(url);

    /// 2
    var directory = await getApplicationDocumentsDirectory();
    String name = '${DateTime.now()}${getFileExtension(link)}';

    File file = File(join(directory.path, name));

    /// 3
    await file.writeAsBytes(response.bodyBytes);

    /// 4
    return file;
  }

  String? convertDateTimeToStringTime({
    required DateTime? dateTime,
    String? placeholder,
    String format = 'yyyy/MM/dd',
  }) {
    if (dateTime == null) return placeholder;
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(dateTime);
  }

  DateTime? convertStringTimeToDateTime({
    required String? time,
    DateTime? placeholder,
    String format = 'yyyy/MM/dd',
  }) {
    if (time == null) return placeholder;
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.parse(time);
  }

  String? convertTimeOfDayToStringTime({
    required TimeOfDay? timeOfDay,
    String? placeholder,
  }) {
    if (timeOfDay == null) return placeholder;
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final min = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }

  TimeOfDay? convertStringTimeToTimeOfDay({
    required String? time,
    String format = 'HH:mm',
  }) {
    if (time == null) return null;
    return TimeOfDay(
      hour: int.parse(time.split(':')[0]),
      minute: int.parse(time.split(':')[1]),
    );
  }

  String? cutDialFromMobile({
    required String? mobile,
    required String? dial,
  }) {
    try {
      if (mobile == null || dial == null) return null;
      return mobile.replaceFirst(dial, '');
    } catch (e) {
      return null;
    }
  }

  String? cutTimeToMinuteSecondOnly(String? time) {
    if (time == null) return null;
    return time.length == 8 ? time.substring(0, 5) : time;
  }

  String convertDurationToMinutesSeconds(Duration duration) {
    int seconds = duration.inSeconds;
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  String convertStringDateToDateTime(String? full) {
    if (full == null) return '';
    String dateTimeString = full;
    DateTime dateTime = DateTime.parse(dateTimeString);

    return DateFormat('yyyy/MM/dd hh:mm a').format(dateTime);
  }

  String getFileExtension(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    int lastDotIndex = path.lastIndexOf('.');

    if (lastDotIndex != -1) {
      return path
          .substring(lastDotIndex); // Returns the extension including the dot
    }

    return ''; // Return empty string if no extension is found
  }

  Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory _directory = Directory("dir");
    if (Platform.isAndroid) {
      _directory = Directory("/storage/emulated/0/Download/AdamGroup");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  Future<File> downloadAndSaveImage(String url) async {
    var response = await http.get(Uri.parse(url));
    Uint8List bytes = response.bodyBytes;

    // Generate a timestamp for the filename
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    String fileName = '${timestamp}_${basename(url)}';
    String filePath = join(await getExternalDocumentPath(), fileName);
    File file = File(filePath);

    try {
      if (await file.exists()) {
        // If the file exists, delete it before writing the new data
        await file.delete();
      }

      await file.writeAsBytes(bytes, flush: true);
      print('Image saved to: $filePath');
      return file; // Move the return statement inside the try block
    } catch (e) {
      print('Error saving image: $e');
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }
}
