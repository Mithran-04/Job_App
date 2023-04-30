// import 'package:flutter/material.dart';
// import 'package:job_app/screens/signin_screen.dart';
// import 'package:job_app/screens/LandingScreen.dart';
// // import 'package:sem_5_project/screens/logIn_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:sem_5_project/screens/Home_screenAdmin.dart';
// class AuthService{
//
//   handleAuthState() {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, snapshot)  {
//           if (snapshot.hasData) {
//             String? _userName=FirebaseAuth.instance.currentUser!.displayName;
//               return LandingScreen(_userName!);
//             }
//
//           return SignInScreen();
//         });
//   }
//
//
//   Future<void> _signOut() async {
//
//     await GoogleSignIn().disconnect();
//     FirebaseAuth.instance.signOut();
//
//   }
//
//
//
//
// }