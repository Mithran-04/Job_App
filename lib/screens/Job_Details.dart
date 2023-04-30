import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sem_5_project/screens/Events_Details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_app/screens/user_form_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobDetails extends StatelessWidget {
  const JobDetails({Key? key}) : super(key: key);

  static const routeName = '/Job-Details';

  @override
  Widget build(BuildContext context) {
    final _JobId = ModalRoute
        .of(context)
        ?.settings
        .arguments as String;

    // print("iddddddddddddddddddddd");
    // print(_eventId);
    return Scaffold(
      extendBodyBehindAppBar:true,
      body: NestedScrollView(
        floatHeaderSlivers: true,

        headerSliverBuilder: (context, innerBoxIsScrolled)
        =>
        [
          SliverAppBar(
            floating: true,
            title: const Text('Job Details'),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
            elevation: 5,
            centerTitle: true,
            backgroundColor: Colors.black,

            // pinned: true,
          ),
        ]
        ,

        body:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF915FB5),
                    Color(0xFFCA436B)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp)
          ),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('Jobs').doc(_JobId).get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: [
                  Center(
                    child: Text(snapshot.data!["Title"],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30,color: Colors.white),),
                  ),

                  Divider(
                      height: 40,color: Colors.black87),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child:Text(snapshot.data!["Description"].replaceAll(RegExp(r'\\n'), '\n'),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),)
                  ),

                  Padding(
                      padding: EdgeInsets.all(8),
                      child:Text("Deadline : ${snapshot.data!["Deadline"].replaceAll(RegExp(r'\\n'), '\n')}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child:Text("Phone No: ${snapshot.data!["phoneNo"].replaceAll(RegExp(r'\\n'), '\n')}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),)
                  ),

                  Padding(
                      padding: EdgeInsets.all(8),
                      child:Text("Email : ${snapshot.data!["Emailid"].replaceAll(RegExp(r'\\n'), '\n')}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child:Text("Location : ${snapshot.data!["Location"].replaceAll(RegExp(r'\\n'), '\n')}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),)
                  ),
                  SizedBox(height: 16,),
                  Center(
                    child:FutureBuilder<bool>(
                        future: isDocumentExist(_JobId),
                        builder: (ctx,snap){
                          if(snap.hasData){
                            if(snap.data==true){
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO((49), 39, 79, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0)
                                    ),
                                    // padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Applied",style: TextStyle(color:Colors.white,fontSize: 23),),
                                    SizedBox(width: 9,),
                                    Icon(Icons.done_outline_rounded,size: 30,color: Colors.greenAccent,),

                                  ],
                                ),



                                onPressed: (){

                                },

                              );
                            }
                          }
                          return ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO((49), 39, 79, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            icon: Icon(Icons.app_registration,size: 30,color: Colors.red,),
                            label: Text("Apply",style: TextStyle(color:Colors.white,fontSize: 23),),
                            onPressed: (){
                              Navigator.of(context).pushNamed(FormDetail.routeName,arguments:snapshot.data!.id);
                            },
                          );
                        }
                    ),
                  ),
                  SizedBox(height:20,)
                  ,
                ]
                ,
              );
            },
          ),
        ),
      ),
    );


  }
  Future<bool> isDocumentExist(String jobId) async{
    DocumentSnapshot<Map<String, dynamic>> document=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection('Applied_Jobs').doc(jobId).get();
    if(document.exists){
      return true;
    }else{
      return false;
    }
  }
}
