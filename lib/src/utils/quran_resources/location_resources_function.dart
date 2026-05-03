import 'dart:convert';
import 'dart:io';

import 'package:al_quran_v3/src/api/apis_urls.dart';
import 'package:al_quran_v3/src/platform_services.dart';
import 'package:al_quran_v3/src/utils/encode_decode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class LocationResourcesFunction {
  static const String _fileName = 'worldcities.json.txt';

  static Future<bool> downloadLocationResources({
    required BuildContext context,
    bool isSetupProcess = false,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${ApisUrls.base}locations/compressed/$_fileName"),
      );

      if (response.statusCode == 200) {
        String? appDataPath = await getApplicationDataPath();
        if (appDataPath == null) return false;

        final file = File(path.join(appDataPath, _fileName));
        
        // Ensure the directory exists
        if (!await file.parent.exists()) {
          await file.parent.create(recursive: true);
        }

        // Save the compressed text exactly as received
        await file.writeAsString(response.body);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error downloading location resources: $e");
      return false;
    }
  }

  static Future<Map?> loadLocationResources() async {
    try {
      String? appDataPath = await getApplicationDataPath();
      if (appDataPath == null) return null;

      final file = File(path.join(appDataPath, _fileName));
      if (!await file.exists()) {
        return null;
      }

      String compressedText = await file.readAsString();
      String jsonString = decodeBZip2String(compressedText);
      return jsonDecode(jsonString);
    } catch (e) {
      debugPrint("Error loading location resources: $e");
      return null;
    }
  }
}
