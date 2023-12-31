import 'dart:convert';

class MapStringAdapter {
  static String mapDocToString(Map<String, dynamic> mapDoc) {
    return jsonEncode(mapDoc);
  }

  static Map<String, dynamic> stringDocToMap(String stringDoc) {
    return jsonDecode(stringDoc);
  }
}
