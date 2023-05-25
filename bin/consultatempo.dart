import 'package:dio/dio.dart';
import 'package:intl/intl.dart' as intl;

final dio = Dio();

double kelvinToCelsius(double kelvin) {
  //não usar caso tenha o parametro units=metric
  double celsius = kelvin - 273.15;
  return celsius;
}

String formataData(String data,
    {String formato = 'dd/MM/yyyy', bool isData = true}) {
  if (!isData) {
    formato = 'HH:mm';
  }
  final dataConversao = DateTime.parse(data);
  final formatoSaida = intl.DateFormat(formato);
  return formatoSaida.format(dataConversao);
}

//ok
Future main() async {
  DateTime now = DateTime.now();

  final apikey = 'bed7d182ed69025a97968f0ea4797309';
  Future consultaTempo(String cidade) async {
    Response response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$apikey&lang=pt_br&units=metric');
    if (response.statusCode == 200) {
      // final dataAtual =
      //     now.add(Duration(milliseconds: response.data['timezone'])).toString();
      final DateTime data =
          DateTime.fromMillisecondsSinceEpoch(response.data['dt'] * 1000);

      print(
          'Temperatura de ${response.data['main']['temp'].toStringAsFixed(2)} C° com ${response.data['weather'][0]['description']} em ${response.data['name']} no dia ${formataData(data.toString(), isData: true)} às ${formataData(data.toString(), isData: false)}');
    } else {
      print('Algo deu errado');
    }
  }

  consultaTempo('Marilia');
}
