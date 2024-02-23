import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

// a class representing a parish, name, coordinates, city, state
class Parish {
  String name;
  String jurisdiction;
  String streetAddress;
  String city;
  String state;
  String zip;
  double latitude;
  double longitude;

  // constructor
  Parish({
    required this.name,
    required this.jurisdiction,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zip,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'jurisdiction': jurisdiction,
        'streetAddress': streetAddress,
        'city': city,
        'state': state,
        'zip': zip,
        'latitude': latitude,
        'longitude': longitude,
      };
}

Future<List<Parish>> scrapeChurches() async {
  const url = '';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('status code: 200');
    final document = parser.parse(response.body);

    final parishes = document.querySelectorAll('.output_parish');

    return parishes.map((parish) {
      final titleElement = parish.querySelector('.parish_title');
      final title = titleElement?.text.trim() ?? '';

      final jurisdictionElement = parish.querySelector('.parish_jurisdiction');
      final jurisdiction = jurisdictionElement?.text.trim() ?? '';

      final streetAddressElement = parish.querySelector('.parish_address');
      final streetAddress = streetAddressElement?.text.trim() ?? '';

      final cityElement = parish.querySelector('.parish_city');
      final city = cityElement?.text.trim() ?? '';

      final stateElement = parish.querySelector('.parish_state');
      final state = stateElement?.text.trim() ?? '';

      final zipElement = parish.querySelector('.parish_zip');
      final zip = zipElement?.text.trim() ?? '';

      final geocodeElement = parish.querySelector('.parish_geocode');
      // final isExact = geocodeElement?.text.trim() == 'exact';

      final latitudeElement = parish.querySelector('.parish_latitude');
      // final latitude = isExact
      //     ? double.tryParse(latitudeElement?.text.trim() ?? '') ?? 0.0
      //     : 0.0;
      final latitude =
          double.tryParse(latitudeElement?.text.trim() ?? '') ?? 0.0;

      final longitudeElement = parish.querySelector('.parish_longitude');
      // final longitude = isExact
      //     ? double.tryParse(longitudeElement?.text.trim() ?? '') ?? 0.0
      //     : 0.0;
      final longitude =
          double.tryParse(longitudeElement?.text.trim() ?? '') ?? 0.0;

      return Parish(
          name: title,
          jurisdiction: jurisdiction,
          streetAddress: streetAddress,
          city: city,
          state: state,
          zip: zip,
          latitude: latitude,
          longitude: longitude);
    }).toList();
  } else {
    throw Exception('Failed to fetch data from website');
  }
}

void main() async {
  final churches = await scrapeChurches();

  // Encode the list of churches as JSON
  final jsonData = jsonEncode(churches);

  // Specify the filename to write the JSON data
  const filename = 'churches.json';

  // Write the JSON data to the file
  await File(filename).writeAsString(jsonData);

  print('Churches saved to $filename');
}
