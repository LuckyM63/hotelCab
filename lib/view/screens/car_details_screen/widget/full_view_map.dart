import 'dart:async';

import 'package:booking_box/core/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../components/buttons/circular_back_button.dart';

class FullViewMap extends StatefulWidget {
  final double lat;
  final double long;

  const FullViewMap({super.key, required this.lat, required this.long});

  @override
  State<FullViewMap> createState() => _FullViewMapState();
}

class _FullViewMapState extends State<FullViewMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long), zoom: 10),
              markers: _markers.values.toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                addMarker('home', LatLng(widget.lat, widget.long), "Home");
              }),
          const Positioned(top: 50, left: 10, child: CircularBackButton()),
        ],
      ),
    );
  }

  addMarker(String id, LatLng location, String title) async {
    //todo: asset img
    final markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      MyImages.marker,
    );

    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(title: title),
      // icon: networkIcon,
      icon: markerIcon,
    );
    _markers[id] = marker;
    setState(() {});
  }
}
