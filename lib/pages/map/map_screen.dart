import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yuzk_mobile/models/PlaceLocationModel.dart';
import 'package:yuzk_mobile/widgets/location_input.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const MapScreen(
      {super.key,
      this.isSelecting = true,
      this.location = const PlaceLocation(
          address: '', latitude: 41.2830952, longitude: 69.2093564)});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your location' : 'Your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if(_pickedLocation!=null){
                  Get.back(result: {'lat' : _pickedLocation!.latitude, 'lng' : _pickedLocation!.longitude});
                }

              },
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting? null: (position){
          setState(() {
            _pickedLocation=position;
          });
        },
        initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.location.latitude, widget.location.longitude),
        zoom: 16,
        ),
        markers: (_pickedLocation==null && widget.isSelecting)?{}: {
           Marker(markerId:  const MarkerId('m1'),
          position: _pickedLocation?? LatLng(widget.location.latitude,
              widget.location.longitude)
          )
        },
      ),
    );
  }
}
