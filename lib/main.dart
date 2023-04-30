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

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: '',
      appId: '',
      messagingSenderId: '',
      projectId: ''));
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
        
      },
    );
  }
}
