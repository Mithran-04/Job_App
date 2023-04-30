import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_app/utils/constants.dart';
import 'package:job_app/utils/widget_functions.dart';
import 'package:job_app/screens/Job_Details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_app/screens/Applied_Jobs_screen.dart';
import 'package:job_app/screens/signin_screen.dart';
import '../utils/widget_functions.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = '/Landing-screen';

  var userNamee =FirebaseAuth.instance.currentUser!.email;
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen> {

  DateTime dateTimeNow=DateTime.now();

  final CollectionReference _events = FirebaseFirestore.instance.collection('Jobs');
  @override
  Widget build(BuildContext context) {
    final endIndex = widget.userNamee!.indexOf('@');
    widget.userNamee=widget.userNamee!.substring(0,endIndex);
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(padding),

              Padding(
                padding: sidePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 36,),
                    TextButton(
                      child: Icon(Icons.logout_outlined, color: COLOR_BLACK),
                      onPressed: () {
                        openDialog();
                      },
                    )
                  ],
                ),
              ),
              // addVerticalSpace(padding),
              Padding(
                padding: sidePadding,
                child: Text(
                  "Job Portal",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                ),
              ),
              addVerticalSpace(15),

              Padding(
                padding: sidePadding,
                child: Row(children: [
                  Text("Welcome ${widget.userNamee}  ",
                      style: themeData.textTheme.headline1),
                  Icon(
                    FontAwesomeIcons.faceSmile,
                    color: Colors.amber[500],
                    size: 30,
                  )
                ]),
              ),

              Padding(
                padding: sidePadding,
                child: Divider(
                  height: padding,
                  color: COLOR_GREY,
                ),
              ),
              addVerticalSpace(10),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO((49), 39, 79, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          padding: EdgeInsets.only(left: 25, right: 25),

                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          // minimumSize: Size(10.0,30.0),
                        ),
                        child: Text(
                          "Applied Jobs",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppliedJobs.routeName);
                        },
                      ),
                    ],
                  )
              ),
              // addVerticalSpace(20),
              SizedBox(
                height: 38,
              ),

              Padding(
                padding: sidePadding,
                child: Text("Jobs",
                    style: themeData.textTheme.headline1),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: StreamBuilder(
                    stream: _events.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final documents = streamSnapshot.data!.docs;

                        return  ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: documents.length,
                            itemBuilder: (ctx, index) {
                                return Card(
                                    key: ValueKey(documents[index]),
                                    margin: EdgeInsets.only(
                                        bottom: 15, left: 6, right: 6),
                                    elevation: 6,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    color: (DateTime
                                        .parse(documents[index]['Deadline'])
                                        .difference(dateTimeNow)
                                        .inDays) > 21
                                        ? Colors.green[200]
                                        : (DateTime
                                        .parse(documents[index]['Deadline'])
                                        .difference(dateTimeNow)
                                        .inDays) > 14
                                        ? Colors.yellow[300]
                                        : Colors.red[300],
                                    child: Column(children: <Widget>[
                                      ListTile(
                                        title: Text(documents[index]['Title'],
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        leading: Icon(
                                          Icons.wysiwyg_rounded,
                                          color: Colors.white,
                                        ),
                                        subtitle: Text(
                                            "Deadline: ${documents[index]['Deadline']}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              JobDetails.routeName,
                                              arguments: documents[index].id);
                                        },
                                      ),
                                    ])
                                );
                            },

    );
                         
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        )
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Alert',
          style: TextStyle(fontSize: 17),
        ),
        content: const Text('Do you want to log out?',style: TextStyle(fontSize: 14),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushNamed(
                    SignInScreen.routeName);
              });
            },
             child: const Text('YES'),
          ),
        ],
      ));


}



