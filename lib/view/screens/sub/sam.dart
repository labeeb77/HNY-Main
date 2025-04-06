import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/service/map_service.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_secondary_button.dart';
import 'package:google_places_flutter/google_places_flutter.dart' as dp;

class LocationPickerScreen extends StatefulWidget {
  final dynamic from;
  const LocationPickerScreen({super.key, required this.from});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? mapController;
  static LatLng _center = const LatLng(25.2048, 55.2708);
  BitmapDescriptor? myIcon;
  bool isMarkerSetisLoading = true;
  List<Placemark> placemarks = [];
  String selectedAddress = "";
  final TextEditingController _searchController = TextEditingController();
  List<Prediction> _placePredictions = [];
  final places = GoogleMapsPlaces(apiKey: "AIzaSyCK4qZ_Nbz1xqiVgI7lkc8LZSiJuZf6rPU");

  @override
  void initState() {
    super.initState();
    loadCustomMarkers();
  }

  Future<void> loadCustomMarkers() async {
    try {
      myIcon = await getBitmapDescriptorFromAsset(
          'assets/icons/Group 1000006910.png', 100);
      setState(() {
        isMarkerSetisLoading = false;
      });
    } catch (e) {
      print("Error loading marker icons: $e");
    }
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAsset(
      String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    final FrameInfo fi = await codec.getNextFrame();
    final Uint8List markerIcon =
        (await fi.image.toByteData(format: ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return BitmapDescriptor.fromBytes(markerIcon);
  }

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      final response = await places.autocomplete(query);
      log(response.predictions.toString());


      if (response.isOkay) {
        setState(() {
          _placePredictions = response.predictions;
        });
      }
    } else {
      setState(() {
        _placePredictions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search Location',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                if (_placePredictions.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white,
                    child: Column(
                      children: _placePredictions.map((prediction) {
                        return ListTile(
                          title: Text(prediction.description ?? ""),
                          onTap: () async {
                            PlacesDetailsResponse details =
                                await places.getDetailsByPlaceId(
                                    prediction.placeId ?? "");
                            double lat = details.result.geometry!.location.lat;
                            double lng = details.result.geometry!.location.lng;
                            _center = LatLng(lat, lng);
                            selectedAddress = prediction.description ?? "";
                            mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(target: _center, zoom: 15.0),
                              ),
                            );
                            setState(() {
                              _placePredictions = [];
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onTap: (argument) async {
                    _center = LatLng(argument.latitude, argument.longitude);

                    mapController?.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                        bearing: 0.0,
                        target: LatLng(argument.latitude, argument.longitude),
                        zoom: 15.0,
                      ),
                    ));

                    final response = await getAddressFromLatLng(
                        argument.latitude, argument.longitude);
                    if (response.isNotEmpty) {
                      selectedAddress = response;
                      setState(() {});
                    }
                  },
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 14.0,
                  ),
                  markers: isMarkerSetisLoading
                      ? Set.from([])
                      : Set.from([
                          Marker(
                            icon: myIcon!,
                            infoWindow:
                                const InfoWindow(title: "PICKUP LOCATION"),
                            markerId: MarkerId(_center.toString()),
                            position: _center,
                            draggable: false,
                          )
                        ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
