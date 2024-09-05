import 'dart:convert';

import 'package:flutter_application_1/data/data_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl =
      'https://api.data.gov.in/resource/990c13aa-4ecf-4ff0-a533-6902e10733b3?api-key=579b464db66ec23bdd0000014228dc549f804cc26da8c8dcb218ea29&format=json';
  Future<List<CropProduction>> fetchCropProduction() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final records = (data['records'] as List)
          .map((record) => CropProduction.fromJson(record))
          .toList();
      return records;
    } else {
      throw Exception('Failed to load crop production data');
    }
  }
}
