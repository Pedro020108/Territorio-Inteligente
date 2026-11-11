import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final double temperature;
  final double windSpeed;
  final int humidity;
  final String description;
  const WeatherData({required this.temperature, required this.windSpeed, required this.humidity, required this.description});
}

class WeatherService {
  // Coordenadas de São Paulo. A API Open-Meteo não exige chave.
  Future<WeatherData> fetchCurrent() async {
    final uri = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=-23.5505&longitude=-46.6333&current=temperature_2m,relative_humidity_2m,wind_speed_10m&timezone=America%2FSao_Paulo');
    final response = await http.get(uri).timeout(const Duration(seconds: 12));
    if (response.statusCode != 200) throw Exception('Não foi possível consultar o clima.');
    final current = jsonDecode(response.body)['current'];
    return WeatherData(
      temperature: (current['temperature_2m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).round(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      description: 'Condições atuais em São Paulo',
    );
  }
}
