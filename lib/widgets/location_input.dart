import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/base/custom_loader.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/data/repository/hive/hive_repo.dart';
import 'package:yuzk_mobile/pages/map/map_screen.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';

import '../models/PlaceLocationModel.dart';
import '../person.dart';
import '../utils/app_const.dart';
final dio = Dio();
class LocationInput extends StatefulWidget {

 const LocationInput({super.key, });
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _addressName='';
  @override
  void initState() {
    super.initState();
      setAddressName();
  }
  var _isGettingLocation=false;

  void setAddressName(){
    Person person=Get.find<HiveRepo>().getPerson;
    // Person person=widget.hiveRepo.getPerson;
    if(person.addresses.trim().isNotEmpty){
      String latString=person.addresses.split('#')[0];
      String lngString=person.addresses.split('#')[1];
      double lat=double.parse(latString);
      double lng=double.parse(lngString);
      _pickedLocation=PlaceLocation(latitude: lat, longitude: lng, address: _addressName);
      _addressName=person.addresses.split("#")[2];
      print('_address $_addressName');
    }else{
      _addressName='No location selected';
    }
  }

  String get locationImage{
    if(_pickedLocation==null) return'';
    final lat=_pickedLocation!.latitude;
    final lng=_pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyD8LNmpNjsv8Oqyq0OAaQHVtDDo7Q_LLVk';
  }
void _savePlace(double lat, double lng)async {
  var response= await dio.get('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyD8LNmpNjsv8Oqyq0OAaQHVtDDo7Q_LLVk');

  var name= response.data['results'][0]['formatted_address'];

  setState(() {
    _addressName=name;
    _pickedLocation=PlaceLocation(latitude: lat,
        longitude: lng,
        address: name);
  });

  String addressOutput='$lat#$lng#$name';
  Get.find<UserController>().updateAddress(addressOutput);
  Person person=Get.find<HiveRepo>().getPerson;
  person.addresses=addressOutput;
  Get.find<HiveRepo>().updatePerson(person);
}
  void _getCurrentLocation()async{

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation=true;
    });

    locationData = await location.getLocation();
    var lat=locationData.latitude;
    var lng=locationData.longitude;
    if(lat==null || lng==null) return;
    try{
      _savePlace(lat, lng);

    }catch(e){
      showCustomSnackBar(message: e.toString());
    }
    setState(() {
      _isGettingLocation=false;
    });

  }

  void _mapView(){
      Get.to(MapScreen(location: _pickedLocation!,isSelecting: false,));
  }
  void _selectFromMap()async{
    Map<String, dynamic> result = await Get.to(const MapScreen(), transition: Transition.rightToLeft);
    _savePlace(result['lat'], result['lng']);



  }
  @override
  Widget build(BuildContext context) {
setAddressName();
    Widget previewContent=Container(
      height: Dimensions.height30*6,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2)
          )
      ),

    );
    if(_pickedLocation!=null){
      previewContent=Image.network(locationImage);
    }
    if(_isGettingLocation){
      previewContent=const CustomLoader();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: Container(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: Dimensions.height20),
              height: Dimensions.height45*2,
            width: double.maxFinite,
            child: Text('Address: $_addressName',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
              ),),),
            GestureDetector(
                onTap: _mapView,
                child: previewContent),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                TextButton.icon(onPressed: _getCurrentLocation,
                    icon: const Icon(Icons.location_on),
                    label: const Text('Get current location')),
                TextButton.icon(onPressed: _selectFromMap,
                    icon: const Icon(Icons.map),
                    label: const Text('Select on map')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
