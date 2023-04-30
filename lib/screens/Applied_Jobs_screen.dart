import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AppliedJobs extends StatefulWidget {
  AppliedJobs({Key? key}) : super(key: key);
  static const routeName = '/Applied_jobs';
  final CollectionReference _Jobs=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection('Applied_Jobs');
  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
        // floating: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Applied Jobs'),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.black),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,


        // pinned: true,
      ),

      extendBodyBehindAppBar: true,
      body: NestedScrollView(

          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [

          ],
          body: Container(

            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFdddad6),Color(0xFFdddad6)],
                    // Color(0xFFCA436B)],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp)
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(1, 26, 1,1),
              child: StreamBuilder(
                  stream: widget._Jobs.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      final documents = streamSnapshot.data!.docs;
                      print("documenttttttt");
                      print(documents);
                      print("Helllooooooooo");

                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: documents.length,
                          itemBuilder: (ctx, index) => Card(
                              margin:
                              EdgeInsets.only(bottom: 15, left: 6, right: 6),
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xFFe07a5f),
                              // margin: EdgeInsets.only(top: 8,bottom: 8,left:1,right:1),
                              child: Column(children: <Widget>[
                                ListTile(
                                  // margin: EdgeInsets.only(bottom:10,left: 6,right: 6),
                                  title: Text(
                                    documents[index]['Position'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                  leading: Icon(Icons.wysiwyg_rounded),
                                  subtitle: Text(
                                      "\n${documents[index]['Description']}\n\n Deadline: ${documents[index]['Deadline']}" ,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                  onTap: () {

                                  },
                                ),
                              ])));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          )),
    );
  }
}
