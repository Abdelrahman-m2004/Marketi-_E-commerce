import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckoutMapPlaceholder extends StatefulWidget {
  const CheckoutMapPlaceholder({super.key});

  @override
  State<CheckoutMapPlaceholder> createState() => _CheckoutMapPlaceholderState();
}

class _CheckoutMapPlaceholderState extends State<CheckoutMapPlaceholder> {
  static const LatLng _location = LatLng(30.4167, 31.6833);

  late GoogleMapController _controller;

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('home'),
      position: _location,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SizedBox(
        height: 180,
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: _location,
            zoom: 11,
          ),
          markers: _markers,
          onMapCreated: (controller) {
            _controller = controller;
            _controller.setMapStyle(_mapStyle);
          },
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          liteModeEnabled: true,
        ),
      ),
    );
  }

  static const String _mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [{"color": "#dce9ff"}]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#7993c5"}]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [{"color": "#dce9ff"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [{"color": "#b2ccff"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#b2ccff"}]
    },
    {
      "featureType": "poi",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "transit",
      "stylers": [{"visibility": "off"}]
    }
  ]
  ''';
}
