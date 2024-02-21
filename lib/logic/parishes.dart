import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

// a class representing a parish, name, coordinates, city, state
class Parish {
  String name;
  String jurisdiction;
  String coordinates;
  String streetAddress;
  String city;
  String state;
  String zip;
  String country;

  // constructor
  Parish({
    required this.name,
    required this.jurisdiction,
    required this.coordinates,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
  });

  Future<List<Parish>> scrapeChurches() async {
    final url = 'https://www.assemblyofbishops.org/directories/parishes/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final parishes = document.querySelectorAll('.parish_info');

      return parishes.map((parish) {
        final titleElement = parish.querySelector('.parish_title');
        final title = titleElement?.text.trim() ?? '';

        final jurisdictionElement =
            parish.querySelector('.parish_jurisdiction');
        final jurisdiction = jurisdictionElement?.text.trim() ?? '';

        final addressLines = parish.querySelectorAll('p');
        final address = addressLines
            .where((p) =>
                p.text.trim().isNotEmpty && !p.text.contains('Show more info'))
            .join(', ');

        final cityStateZip = addressLines.last.text.trim().split(',');
        final city = cityStateZip.isNotEmpty ? cityStateZip[0].trim() : '';
        final state = cityStateZip.length >= 2 ? cityStateZip[1].trim() : '';
        final zip = cityStateZip.length >= 3 ? cityStateZip[2].trim() : '';

        final geocodeElement = parish.querySelector('.parish_geocode');
        final isExact = geocodeElement?.text.trim() == 'exact';

        final latitudeElement = parish.querySelector('.parish_latitude');
        final latitude = isExact
            ? double.tryParse(latitudeElement?.text.trim() ?? '') ?? 0.0
            : 0.0;

        final longitudeElement = parish.querySelector('.parish_longitude');
        final longitude = isExact
            ? double.tryParse(longitudeElement?.text.trim() ?? '') ?? 0.0
            : 0.0;

        // final moreInfoElement = parish.querySelector('.parish_more_info');
        // final phoneElement = moreInfoElement?.querySelector('.parish_phone');
        // final phone = phoneElement?.text.trim() ?? '';

        // final faxElement = moreInfoElement?.querySelector('.parish_fax');
        // final fax = faxElement?.text.trim() ?? '';

        // final websiteElement =
        //     moreInfoElement?.querySelector('.parish_website');
        // final website = websiteElement?.text.trim() ?? '';

        return Parish(
            name: title,
            jurisdiction: jurisdiction,
            address: address,
            city,
            state,
            zip,
            latitude,
            longitude);
      }).toList();
    } else {
      throw Exception('Failed to fetch data from website');
    }
  }

  void main() async {
    final churches = await scrapeChurches();
    for (final church in churches) {
      print(church);
    }
  }
}
