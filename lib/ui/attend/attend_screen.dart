import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_attendance_with_mlkit/ui/attend/camera_screen.dart';
import 'package:student_attendance_with_mlkit/ui/compenents/custom_snackbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:geocoding/geocoding.dart';
import 'package:student_attendance_with_mlkit/ui/home_screen.dart';



class AttendScreen extends StatefulWidget {
  const AttendScreen({super.key, required this.image});
  final XFile? image;

  @override
  State<AttendScreen> createState() => _AttendScreenState(image);
}

class _AttendScreenState extends State<AttendScreen> {
  _AttendScreenState(this.image);
  XFile? image;
  String? strAddress, strDate, strTime, strDateTime, strStatus = "attend";
  bool isLoading = false;
  double dLat = 0.0, dLong = 0.0;
  int dateHours = 0, dateMinute = 0;
  final controllerName = TextEditingController();
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendence');

  @override
  void initState() {
    // TODO: implement initState
    handleLocationPermission();
    setDateTime();
    setStatusAbsen();
    if(image != null){
      isLoading = true;
      getGeolocationPosition();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text("Attendence Menu", style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
        
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                  color: Colors.blueAccent
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12,),
                    Icon(Icons.face_retouching_natural_outlined, color: Colors.white,),
                    SizedBox(width: 12,),
                    Text("please take a selfie photo", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Text("Capture Photo", style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen(),
                )),
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  height: 150,
                  width: size.width,
                  child: DottedBorder(
                    radius: Radius.circular(10), 
                    borderType: BorderType.RRect,
                    color: Colors.blueAccent,
                    strokeWidth: 1,
                    dashPattern: [5, 5],
                    child: SizedBox.expand(
                      child: FittedBox(
                        child: image != null ? Image.file(File(image!.path),fit: BoxFit.cover,) : Icon(Icons.camera_enhance_outlined, color: Colors.blueAccent,),
                      ),
                    ),
                  ),
                )
              ),
              Padding(padding: 
              EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: controllerName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, ),
                  labelText: "Your Name",
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent
                  ),
                  hintText: "Enter your name",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
              child: Text("Your Location", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent
              ),),
              ),
              isLoading 
              ? const Center(child: CircularProgressIndicator(color: Colors.blueAccent),) 
              : Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  height: 5 * 24,
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    enabled: false,
                    maxLines: 5,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(10),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      hintText: strAddress != null 
                      ? strAddress
                      : strAddress = "Your Location",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                      ),
                      fillColor: Colors.transparent,
                      filled: true
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(30),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.white
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent,
                      child: InkWell(
                        splashColor: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: Text("Report Now",style:  TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                        onTap: (){
                          if(image == null || controllerName.text.isEmpty){
                           customSnackbar(context, Icons.info_outline, "Please complete the form!");
                          }else{
                            SubmitAbsen(strAddress!,strStatus!,controllerName.text.toString(),);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      customSnackbar(context, Icons.location_off, 'Location services are disabled, please enable them in your device settings.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        customSnackbar(context, Icons.cancel,'Location permisson denied');
      return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      customSnackbar(context, Icons.cancel, 'Location permisson denied forever, we cant request permisson');
      return false;
      }

      return true;
  }
  void setDateTime(){
    var dateNow = DateTime.now();
    var dateFormat = DateFormat('dd MMMM yyyy');
    var dateTime = DateFormat ('HH:mm:ss');
    var dateHour = DateFormat('HH');
    var dateMinutes = DateFormat('mm');

    setState(() {
      strDate = dateFormat.format(dateNow);
      strTime = dateTime.format(dateNow);
      strDateTime = "$strDate | $strTime";
      dateHours = int.parse(dateHour.format(dateNow));
      dateMinute = int.parse(dateMinutes.format(dateNow));
    });
  }
  void setStatusAbsen(){
  if(dateHours < 8 || (dateHours == 8 && dateMinute <= 30)){
    strStatus = "Attend";
  }else if((dateHours > 8 && dateHours < 18) || (dateHours == 8 && dateMinute >= 31)){
    strStatus = "Late";
  }else{
    strStatus = "Absent";
  }
 }
 Future<void> getGeolocationPosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      // dLat = position.latitude;
      // dLong = position.longitude;
      isLoading = false;
    });
    getAddressFromLongLat(position);

  }

  Future<void>getAddressFromLongLat(Position position) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    setState(() {
      dLat = position.latitude;
      dLong = position.longitude;

      strAddress = "${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.country}";
    });
  }

  showLoaderDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Text('Checking data...')
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

  Future<void> SubmitAbsen(String? alamat, String? status, String name) async {
    showLoaderDialog(context);
    dataCollection.add({
      "address": alamat,  
      "name": name,
      "status": status,
      "dateTime": strDateTime
      }).then((result){
        setState(() {
          Navigator.pop(context);
          try{
            customSnackbar(context, Icons.check_circle, "Yeay! Attendance Report Succeeded");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }catch(e){
            customSnackbar(context, Icons.error, "Ups, Error: $e");
          }
        });
      }).catchError((error){
        customSnackbar(context, Icons.error, "Ups, Error: $error");
      });
  }
}