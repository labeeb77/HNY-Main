import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_secondary_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search bar

          // Map view
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

                    placemarks = await placemarkFromCoordinates(
                        argument.latitude, argument.longitude);

                    if (placemarks.isNotEmpty) {
                      selectedAddress = _formatAddress(placemarks.first);
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
                            position: LatLng(
                                _center.latitude ?? 25.2048, _center.longitude),
                            draggable: false,
                          )
                        ]),
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: false,
                  zoomGesturesEnabled: true,
                  padding: const EdgeInsets.all(0),
                  buildingsEnabled: true,
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  compassEnabled: true,
                  indoorViewEnabled: false,
                  mapToolbarEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  trafficEnabled: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(16),
                    child: TextField(
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
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select ${widget.from} Location',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 32),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16), 
                    Expanded(
                      child: Text( 
                        selectedAddress.isNotEmpty
                            ? selectedAddress
                            : "Choose a location",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const Gap(42),
                Row(
                  children: [
                    const Spacer(),
                    const SizedBox(width: 10),
                    Expanded(
                        child: SecondaryButton(
                      text: "Cancel",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryElevateButton(
                        buttonName: "Add Location",
                        ontap: () {
                          if (selectedAddress.isNotEmpty) {
                            Navigator.pop(context, selectedAddress);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(24)
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(Placemark placemark) {
    List<String> addressParts = [
      placemark.street ?? '',
      placemark.subLocality ?? '',
      placemark.locality ?? '',
      placemark.administrativeArea ?? '',
      placemark.country ?? '',
    ];

    return addressParts.where((part) => part.isNotEmpty).join(', ');
  }
}
