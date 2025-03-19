import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  const String apiKey =
      "AIzaSyBKmlLrkw4DYk2jylNc8DbfGgB7QWyuxqk"; // Replace with your API key
  final String url =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data["status"] == "OK") {
      final formattedAddress = data["results"][0]["formatted_address"];
      return formattedAddress;
    } else {
      return "No address found";
    }
  } else {
    return "Failed to fetch address";
  }
}
