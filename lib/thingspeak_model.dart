// thingspeak_model.dart

class ThingSpeakData {
  final double temperature;
  final double humidity;

  ThingSpeakData({
    required this.temperature,
    required this.humidity,
  });

  // Factory method untuk membuat instance dari ThingSpeakData
  factory ThingSpeakData.fromJson(Map<String, dynamic> json) {
    // Pastikan Anda menyesuaikan field berikut sesuai dengan field di ThingSpeak
    final double temp = double.tryParse(json['field1'] ?? '0') ?? 0.0;
    final double hum = double.tryParse(json['field2'] ?? '0') ?? 0.0;

    return ThingSpeakData(
      temperature: temp,
      humidity: hum,
    );
  }
}
