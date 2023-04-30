import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppliedUserAdminScreen extends StatefulWidget {
  const AppliedUserAdminScreen({Key? key}) : super(key: key);
  static const routeName = '/Applied_User_Admin_screen';

  @override
  State<AppliedUserAdminScreen> createState() => _AppliedUserAdminScreenState();
}

class _AppliedUserAdminScreenState extends State<AppliedUserAdminScreen> {
  @override
  Widget build(BuildContext context) {
    final _Jobid=ModalRoute.of(context)?.settings.arguments as String;
    CollectionReference _Users= FirebaseFirestore.instance.collection('Jobs').doc(_Jobid).collection('Applied_Users');
    return  Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            // floating: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Padding(padding: EdgeInsets.fromLTRB(500, 90, 20, 80),child: const Text('Applied Users')),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.white),
            elevation: 1,
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

                    stream: _Users.snapshots(),

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
                                    child:Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:<Widget>[
                                            SizedBox(height: 10,),
                                            Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 16,
                                                child: Icon(Icons.account_circle_sharp,color: Colors.black87,),//CircleAvatar
                                              ),
                                            ),
                                            // margin: EdgeInsets.only(bottom:10,left: 6,right: 6),

                                            Text(documents[index]['Name'],style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500,color: Colors.white),),
                                            // Icon(Icons.account_circle_sharp,color: Colors.white,)

                                            Text("mail id: ${documents[index]['Email id']}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),
                                            Text("Age: ${documents[index]['Age']}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),
                                            Text("Experience : ${documents[index]['Experience'] }",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),
                                            Text("Qualification : ${documents[index]['Qualification'] }",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),
                                            SizedBox(height: 10,),
                                          ]
                                      ),
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

