// thingspeak_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'thingspeak_model.dart';

class ThingSpeakService {
  final String _apiKey = 'SN22BQQQO8YEK5QD'; // Ganti dengan API Key Anda
  final String _channelId = '2740951'; // Ganti dengan Channel ID Anda
  final String _baseUrl = 'https://api.thingspeak.com';

  // Fungsi untuk mengambil data terbaru dari ThingSpeak
  Future<ThingSpeakData?> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/channels/$_channelId/feeds.json?results=1&api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        // Mendapatkan data terbaru (feed terakhir)
        final feeds = json['feeds'];
        if (feeds != null && feeds.isNotEmpty) {
          final latestData = feeds.last;
          return ThingSpeakData.fromJson(latestData);
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    return null;
  }
}
