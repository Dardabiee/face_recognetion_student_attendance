import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:student_attendance_with_mlkit/ui/compenents/custom_snackbar.dart';
import 'package:student_attendance_with_mlkit/ui/home_screen.dart';

class AbsentScreen extends StatefulWidget {
  const AbsentScreen({super.key});

  @override
  State<AbsentScreen> createState() => _AbsentScreenState();
}

class _AbsentScreenState extends State<AbsentScreen> {
    String? strAddress, strDate, strTime, strDateTime, strStatus = "attend";
    double dLat = 0.0, dLong = 0.0;
    int dateHours = 0, dateMinute = 0;

    final controllerName = TextEditingController();
    final controllerFrom = TextEditingController();
    final controllerTo = TextEditingController();

    String dropValueCategory = "Please Choose";
    List<String> categoriesList = [
      "Please Choose",
      "Absent",
      "Present",
      "Permission",
      "Sick"
    ];
    final CollectionReference dataCollection = FirebaseFirestore.instance.collection('absent');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text("Permission Request Menu", style: TextStyle(
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
          margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.blueAccent,
                ),
                child:const Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.maps_home_work, color: Colors.white,),
                      SizedBox(
                      width: 12,
                    ),
                    Text("Please fill the form!", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                     ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: TextField(
                textInputAction: TextInputAction.next,
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
              const Padding(padding: EdgeInsets.all(10),
              child: Text("Decription",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent
              ),),
              ),
              Padding(padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey, 
                    style: BorderStyle.solid,
                    width: 1),
                ),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  value: dropValueCategory,
                  onChanged: (String? value){
                    setState(() {
                      dropValueCategory = value!;
                    });
                  },
                  items: categoriesList.map((value){
                    return DropdownMenuItem(
                      value: value.toString(),
                      child: Text(value.toString(),style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent
                      ),),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 14
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  isExpanded: true,
                 )
               ),
              ),
              Padding(padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(child: Row(
                    children: [
                      Text("From : ",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                       ),
                      ),
                      Expanded(child: TextField(
                        readOnly: true,
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(
                            context: context, 
                            firstDate: DateTime(2000), 
                            lastDate: DateTime(2059),
                            initialDate: DateTime.now(),
                            builder: (BuildContext context, Widget? child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(
                              onPrimary: Colors.white,
                              onSurface: Colors.blueAccent,
                              primary: Colors.blueAccent
                             ),
                             datePickerTheme: DatePickerThemeData(
                              headerBackgroundColor: Colors.blueAccent,
                              backgroundColor: Colors.white,
                              headerForegroundColor: Colors.white,
                              surfaceTintColor: Colors.white
                              )
                            ), 
                            child: child!
                            ),
                          );
                          if(pickedDate != null){
                            controllerFrom.text = DateFormat("dd/M/yyyy").format(pickedDate);
                          }
                        },
                        controller: controllerFrom,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Starting From",
                          hintStyle: TextStyle(color: Colors.blueAccent)
                        ),
                       )
                      )
                    ]
                   ),
                  ),
                  SizedBox(
                  width: 14,
                ),
                Expanded(child: Row(
                    children: [
                      Text("To : ",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                       ),
                      ),
                      Expanded(child: TextField(
                        readOnly: true,
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(
                            context: context, 
                            firstDate: DateTime(2000), 
                            lastDate: DateTime(2059),
                            initialDate: DateTime.now(),
                            builder: (BuildContext context, Widget? child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(
                              onPrimary: Colors.white,
                              onSurface: Colors.blueAccent,
                              primary: Colors.blueAccent
                             ),
                             datePickerTheme: DatePickerThemeData(
                              headerBackgroundColor: Colors.blueAccent,
                              backgroundColor: Colors.white,
                              headerForegroundColor: Colors.white,
                              surfaceTintColor: Colors.white
                              )
                            ), 
                            child: child!
                            ),
                          );
                          if(pickedDate != null){
                            controllerTo.text = DateFormat("dd/M/yyyy").format(pickedDate);
                          }
                        },
                        controller: controllerTo,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Until",
                          hintStyle: TextStyle(color: Colors.blueAccent)
                        ),
                       )
                      )
                    ]
                   ),
                  ),
                ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(30),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
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
                          child: Text("Make a Request",style:  TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                        onTap: (){
                          if(controllerName.text.isEmpty || controllerFrom.text.isEmpty|| controllerTo.text.isEmpty || dropValueCategory == "Please Choose"){
                          customSnackbar(context, Icons.info_outline, "Ups, Please fill the form!");
                          } else{
                            SubmitAbsent("-", dropValueCategory, controllerName.text, controllerFrom.text, controllerTo.text);
                          }
                        },
                       ),
                     ),
                    ),
                  ),
                 )
               )
              )
            ],
          ),
        ),
      ),
    );
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

  Future<void> SubmitAbsent(String alamat, String status, String name, String from, String until) async {
    showLoaderDialog(context);
    dataCollection.add({
      "adress": alamat, 
      "name": name,
      "status": status,
      "dateTime": '$from - $until',
      }).then((result){
        setState(() {
          Navigator.pop(context);
          try{
            customSnackbar(context, Icons.check_circle, "Yeay! Absent Report Succeeded");
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