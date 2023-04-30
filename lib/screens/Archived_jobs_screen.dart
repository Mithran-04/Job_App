import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_app/screens/Applied_user_Admin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_app/screens/Admin_form_screen.dart';
import 'package:job_app/screens/signin_screen.dart';

class ArchivedJobsScreen extends StatefulWidget {
  const ArchivedJobsScreen({Key? key}) : super(key: key);
  static const routeName = '/ArchivedJobs';
  @override
  State<ArchivedJobsScreen> createState() => _ArchivedJobsScreenState();
}

class _ArchivedJobsScreenState extends State<ArchivedJobsScreen> {
  final CollectionReference _events=FirebaseFirestore.instance.collection('Archived_Jobs');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            // floating: true,
            iconTheme: IconThemeData(color: Colors.black),
            title: Padding(padding: EdgeInsets.fromLTRB(450, 60, 0, 24),child: const Text('Archived Jobs')),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.white),
            elevation: 10,
            // centerTitle: true,
            backgroundColor: Colors.black,
            // pinned: true,
          ),
        ),
        backgroundColor: Colors.white,
        body : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35,),
              Padding(
                padding: EdgeInsets.all(1),
                child: StreamBuilder(
                    stream: _events.snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final documents = streamSnapshot.data!.docs;
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: documents.length,
                            itemBuilder: (ctx,index)=>
                                Card(
                                    margin: EdgeInsets.only(bottom:15,left: 6,right: 6),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    color: Colors.deepPurple[300],
                                    // margin: EdgeInsets.only(top: 8,bottom: 8,left:1,right:1),
                                    child:Column(
                                        children:<Widget>[
                                          ListTile(
                                            title: Text(documents[index]['Title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                                            leading: Icon(Icons.wysiwyg_rounded,color: Colors.white,),
                                            subtitle: Text("\n${documents[index]['Description']} \n\nDeadline: ${documents[index]['Deadline']} ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),

                                            // trailing: IconButton(
                                            //   icon: Icon(Icons.,color: Colors.white),
                                            //   onPressed: (){
                                            //
                                            //   },
                                            // ),
                                            onTap: (){
                                            },
                                          ),
                                        ]
                                    )
                                )
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                ),
              ),



            ],
          ),
        )
    );

  }

}
