import 'package:dio/dio.dart';
import 'package:intl/intl.dart' as intl;

final dio = Dio();

String formataData(String data,
    {String formato = 'dd/MM/yyyy', bool isData = true}) {
  if (!isData) {
    formato = 'HH:mm';
  }
  final dataConversao = DateTime.parse(data);
  final formatoSaida = intl.DateFormat(formato);
  return formatoSaida.format(dataConversao);
}

Future main() async {
  var url = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: 'data/2.5/weather',
      queryParameters: {
        'lat': "-22.2138900",
        'lon': "-49.9458300",
        'appid': 'bed7d182ed69025a97968f0ea4797309',
        'lang': 'pt_br',
        'units': 'metric',
        'q': 'Marilia'
      });
  Response response = await dio.get(url.toString());

  final DateTime data =
      DateTime.fromMillisecondsSinceEpoch(response.data['dt'] * 1000);
  print(
      "Temperatura atual ${response.data['main']['temp'].toStringAsFixed(2)} °C em ${response.data['name']}. Consultado em ${formataData(data.toString())}");
}
