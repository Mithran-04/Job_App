import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_app/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_app/utils/constants.dart';
import 'package:job_app/screens/Admin_form_screen.dart';
import 'package:job_app/screens/Applied_user_Admin_screen.dart';
import 'dart:ui';
import 'screens/LandingScreen.dart';
import 'package:job_app/screens/Job_Details.dart';
import 'package:job_app/screens/Admin_job_list.dart';
import 'package:job_app/screens/user_form_screen.dart';
import 'package:job_app/screens/Applied_Jobs_screen.dart';
import 'package:job_app/screens/Archived_jobs_screen.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:sem_5_project/screens/auth_screen1.dart';
// import 'package:sem_5_project/screens/Events_Details.dart';
// import 'package:sem_5_project/screens/Form_screen.dart';
// import 'package:sem_5_project/screens/Registered_Events_screen.dart';
// import 'package:sem_5_project/screens/Attedance_screen.dart';
// import 'package:sem_5_project/screens/Form_screenAdmin.dart';
// import 'package:sem_5_project/screens/Registered_screenAdmin.dart';
// import 'package:sem_5_project/screens/Home_screenAdmin.dart';
// import 'package:sem_5_project/screens/Message_AdminScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: 'AIzaSyCt4KG50zj5RPQLD5m_eRH40pr3_6jxQoQ',
      appId: '1:723354314063:android:0395fec12e2c7f3318113a',
      messagingSenderId: '',
      projectId: 'jobapp-1a125'));
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    double screenWidth=window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App 1',
      theme: ThemeData(primaryColor: COLOR_WHITE,hintColor: COLOR_DARK_BLUE,textTheme: screenWidth<500? TEXT_THEME_SMALL: TEXT_THEME_DEFAULT,fontFamily: "Montserrat"),
      home: SignInScreen(),
      routes: {
        SignInScreen.routeName:(ctx)=>SignInScreen(),
        LandingScreen.routeName:(ctx)=>LandingScreen(),
        JobDetails.routeName:(ctx)=> JobDetails(),
        AdminHomeScreen.routeName:(ctx)=> AdminHomeScreen(),
        FormDetail.routeName:(ctx)=> FormDetail(),
        AppliedJobs.routeName:(ctx)=>AppliedJobs(),
        AdminFormScreen.routeName:(ctx)=> AdminFormScreen(),
        AppliedUserAdminScreen.routeName:(ctx)=>AppliedUserAdminScreen(),
        ArchivedJobsScreen.routeName:(ctx)=>ArchivedJobsScreen(),
        // RegisteredEvents.routeName:(ctx)=>RegisteredEvents(),
        // AttendanceScreen.routeName:(ctx)=>AttendanceScreen(),
        // FormScreen.routeName:(ctx)=> FormScreen(),
        // RegisteredScreen.routeName:(ctx)=> RegisteredScreen(),
        // HomeScreen.routeName:(ctx)=> HomeScreen(),
        // MessageScreen.routeName:(ctx)=>MessageScreen(),
        // MessageUserScreen.routeName:(ctx)=> MessageUserScreen(),
      },
    );
  }
}