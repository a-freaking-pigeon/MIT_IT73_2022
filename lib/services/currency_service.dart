import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static Future<double> getRsdToEurRate() async {
    final response = await http.get(
      Uri.parse(
        'https://api.exchangerate.host/latest?base=RSD&symbols=EUR',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['rates']['EUR'] as num).toDouble();
    } else {
      throw Exception('Neuspešno preuzimanje kursa.');
    }
  }
}