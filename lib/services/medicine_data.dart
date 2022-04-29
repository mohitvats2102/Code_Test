import 'dart:convert';

import 'package:http/http.dart' as http;

class MedicineData {
  static Future<List<Map<dynamic, dynamic>>> getData() async {
    final Uri url = Uri.parse(
        'https://run.mocky.io/v3/0d33ef1e-3ea2-4f34-b72d-c8fe05516ac4');
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    Map<String, dynamic> formattedData = decodedData['problems'][0]['Diabetes']
        [0]['medications'][0]['medicationsClasses'][0] as Map<String, dynamic>;

    final List<dynamic> finalData = formattedData.values.toList();
    final List<Map<dynamic, dynamic>> list = [];
    finalData.map((item) {
      final data = item[0].values.toList();
      for (int i = 0; i < data.length; i++) {
        list.add(data[i][0]);
      }
    }).toList();
    return list;
  }
}
