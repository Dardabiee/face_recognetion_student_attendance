import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_attendance_with_mlkit/ui/absent/absent_screen.dart';
import 'package:student_attendance_with_mlkit/ui/attend/attend_screen.dart';
import 'package:student_attendance_with_mlkit/ui/attendence_history/attendence_history.dart';
import 'package:camera/camera.dart';

class HomeScreen extends StatelessWidget {
  final XFile? image;
  const HomeScreen({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (bool didPop){
        if(didPop){
          return;
        }
        _onWillPop(context);
      },
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              
              margin: EdgeInsets.all(10),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child:Expanded(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AttendScreen(image: null,),
                    )
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                                    children: [
                    Image.asset('assets/images/ic_absen.png', height: 100,width: 100,),
                    SizedBox(width: 10,),
                    Text('Attendance', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),)
                                    ],
                                  ),
                  ),
                 ),
                ),
              ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child:Expanded(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AbsentScreen(),)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                     children: [
                        Image.asset('assets/images/ic_leave.png', height: 100,width: 100,),
                        SizedBox(width: 10,),
                        Text('Absent or Permitted', style: TextStyle(
                          color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),)
                     ],
                    ),
                  ),
                 )
                )
              ),
              SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child:Expanded(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceHistoryScreen(),)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                     children: [
                        Image.asset('assets/images/ic_history.png', height: 100,width: 100,),
                        SizedBox(width: 10,),
                        Text('Attendance history', style: TextStyle(
                          color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),)
                     ],
                    ),
                  ),
                 )
                )
              ),
          ],
        ),
       ),
      ),
    ));

    
  }
  Future<bool> _onWillPop(BuildContext context) async{
      return (await showDialog(context: context, builder: (context) => AlertDialog(
         title: const Text('INFO', style: TextStyle(
          color: Colors.black, 
          fontSize: 20,fontWeight: 
          FontWeight.bold),
          ),
          content: const Text('Do you want to exit the app?', style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400
          ),),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No', style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w400
              ),),
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: Text('Yes', style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.w400
              ),),
            )
          ],
        ),
      ) ?? false);
  }
}