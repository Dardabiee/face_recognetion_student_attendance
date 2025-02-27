import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';



class GetLocationScreen extends StatefulWidget {
  const GetLocationScreen({super.key});

  @override
  State<GetLocationScreen> createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  String? latitude;
  String? longitude;
  String? address;  
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async{
    setState(() {
      isLoading = true;
    });
    try{
      // minta izin akses lokasi
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
         permission = await Geolocator.requestPermission();
         if(permission == LocationPermission.denied){
          setState(() {
            isLoading = false;
            address = 'Permission Denied';
          });
          return ;
         }
      }
      //JIKA DENIED FOREVER MAKA AKAN BUKA SETTING
      if(permission == LocationPermission.deniedForever){
        setState(() {
          isLoading = false;
          address = 'Permission Denied Forever please enable from setting';
        });
      }
      Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high)
      );
      // convert latitude dan longitude ke alamat
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark placemark = placemarks[0];
      setState(() {
        isLoading = false;
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        address = "${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
      });
    }catch(e){
      isLoading = false;
      print("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator and Geocode'),
      ),
      body: Center(
        child: isLoading 
        ? CircularProgressIndicator() 
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Latitude: ${latitude}, Longitude: ${longitude}", style: const TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Text(address ?? 'No Data'),
          ],
        ),
      ),
    );
  }
}