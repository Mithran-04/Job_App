import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_app/screens/Applied_user_Admin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_app/screens/Admin_form_screen.dart';
import 'package:job_app/screens/signin_screen.dart';
import 'package:job_app/screens/Archived_jobs_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  static const routeName = '/Admin_Home';
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  DateTime dateTimeNow=DateTime.now();
  final CollectionReference _events=FirebaseFirestore.instance.collection('Jobs');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            // floating: true,
            iconTheme: IconThemeData(color: Colors.black),
            title: Padding(padding: EdgeInsets.fromLTRB(0, 60, 10, 24),child: const Text('Admin')),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: Colors.white),
            elevation: 1,
            centerTitle: true,
            backgroundColor: Colors.black,
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(1,24,0,10),
                child: IconButton(onPressed: (){
                   Navigator.of(context).pushNamed(AdminFormScreen.routeName);
                }, icon: const Icon(Icons.add,color: Colors.white,size: 26,)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(1,24,0,10),
                child: IconButton(onPressed: (){
                  Navigator.of(context).pushNamed(ArchivedJobsScreen.routeName);
                }, icon: const Icon(Icons.archive_sharp,color: Colors.white,size: 26,)),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(1,24,10,4),
                child: IconButton(onPressed: (){
                  openDialogOut();
                }, icon: const Icon(Icons.logout_outlined,color: Colors.white,size: 26,)),
              )
            ],


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
                        return ReorderableExample(documents);
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
  Future openDialogOut() => showDialog(
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
              FirebaseAuth.instance.signOut().then((value){
                Navigator.of(context).pushNamed(
                    SignInScreen.routeName);
              });

            },
            child: const Text('YES'),
          ),
        ],
      ));

}
class ReorderableExample extends StatefulWidget {
  final documents;
  const ReorderableExample(List<QueryDocumentSnapshot<Object?>> this.documents, {Key? key}) : super(key: key);

  @override
  State<ReorderableExample> createState() => _ReorderableExampleState();
}

class _ReorderableExampleState extends State<ReorderableExample> {
  DateTime dateTimeNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // final documents = ModalRoute
    //     .of(context)
    //     ?.settings
    //     .arguments;
    return ReorderableListView.builder(

        onReorder: (oldIndex, newIndex) {
          final newPos = newIndex > oldIndex ? newIndex - 1 : newIndex;
          setState(() {
            final temp = widget.documents.removeAt(oldIndex);
            widget.documents.insert(newPos, temp);
          });
        },

        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.documents.length,
        itemBuilder: (ctx, index) =>
            Card(
                key: ValueKey(widget.documents[index]),
                margin: EdgeInsets.only(
                    bottom: 15, left: 6, right: 6),
                elevation: 6,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                color: (DateTime
                    .parse(widget.documents[index]['Deadline'])
                    .difference(dateTimeNow)
                    .inDays) > 21 ? Colors.green[200] : (DateTime
                    .parse(widget.documents[index]['Deadline'])
                    .difference(dateTimeNow)
                    .inDays) > 14 ? Colors.yellow[300] : Colors.red[300],
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text(
                      widget.documents[index]['Title'],
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
                        "Deadline: ${widget.documents[index]['Deadline']}",
                        style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    trailing: IconButton(
                      icon: Icon(Icons.archive_outlined, color: Colors.white),
                      onPressed: () {
                        openDialog(widget.documents[index].id);
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          AppliedUserAdminScreen.routeName,
                          arguments: widget.documents[index].id);
                    },
                  ),
                ])
            ));
  }

  Future openDialog(String id) =>
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Alert!!', style: TextStyle(fontSize: 15),),
                content: const Text('Are you sure you want to Archive'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },

                    child: const Text('NO'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      var collection = FirebaseFirestore.instance.collection(
                          'Jobs');
                      var docSnapshot = await collection.doc(id).get();
                      if (docSnapshot.exists) {
                        Map<String, dynamic>? data = docSnapshot.data();
                        final _refer = FirebaseFirestore.instance.collection(
                            'Archived_Jobs').doc(id);
                        _refer.set({
                          'Title': data!['Title'],
                          'Deadline': data['Deadline'],
                          'Description': data['Description'],
                        });
                        FirebaseFirestore.instance.collection("Jobs").doc(id).delete();
                      };
                    },
                    child: const Text('YES'),
                  ),


                ],
              )

      );
}
