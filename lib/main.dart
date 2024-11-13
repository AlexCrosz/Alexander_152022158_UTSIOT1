import 'package:flutter/material.dart';
import 'thingspeak_service.dart';
import 'thingspeak_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThingSpeak Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ThingSpeakScreen(),
    );
  }
}

class ThingSpeakScreen extends StatefulWidget {
  const ThingSpeakScreen({super.key});

  @override
  _ThingSpeakScreenState createState() => _ThingSpeakScreenState();
}

class _ThingSpeakScreenState extends State<ThingSpeakScreen> {
  final ThingSpeakService _service = ThingSpeakService();
  ThingSpeakData? _data;
  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final data = await _service.fetchData();
    setState(() {
      _data = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThingSpeak Monitor'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.blue.shade50,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header dengan Judul dan Logo
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Menambahkan logo di tengah berbentuk lingkaran
                    Center(
                      child: ClipOval(
                        child: SizedBox(
                          width: 80, // Ukuran tetap untuk logo
                          height: 80,
                          child: Image.asset(
                            'assets/images/logo.png', // Pastikan file logo ada di folder assets/images/
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 40,
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'UTS IoT',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Nama: Alexander\nNRP: 152022158',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Body Data
              _isLoading
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Memuat data, mohon tunggu...'),
                ],
              )
                  : _data == null
                  ? const Text(
                'Gagal memuat data',
                style: TextStyle(fontSize: 18, color: Colors.red),
              )
                  : Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.thermostat,
                              color: Colors.blue, size: 30),
                          Text(
                            'Suhu: ${_data!.temperature.toStringAsFixed(2)}°C',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.water_drop,
                              color: Colors.blue, size: 30),
                          Text(
                            'Kelembaban: ${_data!.humidity.toStringAsFixed(2)}%',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
