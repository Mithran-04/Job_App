import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_validator/string_validator.dart';

class FormDetail extends StatefulWidget {
  static const routeName='/Form_Detail';
  @override
  State<FormDetail> createState() => _FormDetailState();
}
class _FormDetailState extends State<FormDetail> {
  final formKey = GlobalKey<FormState>();
  String Name = '';
  String Age='';
  String Exp = '';
  String Qualification = '';

  @override
  Widget build(BuildContext context) {
    final _JobId = ModalRoute
        .of(context)
        ?.settings
        .arguments as String;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Padding(
              padding: EdgeInsets.fromLTRB(40, 60, 20, 24),
              child: const Text('Enter the details')),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),
          elevation: 1,
          // centerTitle: true,
          backgroundColor: Colors.black,

        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF915FB5),
                  Color(0xFFCA436B)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp)
        ),
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: 50,),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name cannot be empty!';
                  }
                  else {
                    return null;
                  }
                },
                onSaved: (value) => setState(() => Name = value!),
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              SizedBox(height: 50,),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Age cannot be empty!';
                  }
                  else if(!isNumeric(value)){
                        return('Experience should be numeric!');
                  }
                  else {
                    return null;
                  }
                },
                onSaved: (value) => setState(() => Age= value!),
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              const SizedBox(height: 34),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Experience',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Experience cannot be empty!';
                  } else if (!isNumeric(value)){
                    return('Experience should be numeric!');}
                  else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                onSaved: (value) => setState(() => Exp = value!),
              ),
              const SizedBox(height: 34),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Qualification',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Qualification cannot be empty';
                  }
                  else {
                    return null;
                  }
                },
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                onSaved: (value) => setState(() => Qualification = value!),
                keyboardType: TextInputType.text,

              ),

              const SizedBox(height: 34),

              Builder(
                builder: (context) =>
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO((49), 39, 79, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          // icon: Icon(Icons.app_registration,size: 30,color: Colors.red,),
                          child: Text("Submit",
                            style: TextStyle(color: Colors.white, fontSize: 23),),

                          onPressed: () async {
                            final isValid = formKey.currentState!.validate();
                            FocusScope.of(context).unfocus();

                            if (isValid) {
                              formKey.currentState!.save();
                              DocumentReference _documentReference=FirebaseFirestore.instance.collection('Jobs').doc(_JobId);
                              // print("docccccc");
                              // print(_documentReference.collection('count') );
                              // print("Yesss");
                              // print(_documentReference.collection('count').get());
                              // QuerySnapshot _data =await _documentReference.collection('count').get();
                              // print(_data.docs);
                              CollectionReference _reference=_documentReference.collection('Applied_Users');

                              _reference.add({
                                'Email id': FirebaseAuth.instance.currentUser!.email,
                                'Name':Name,'Age': Age,'Qualification': Qualification,'Experience':Exp},
                              );
                              var collection = FirebaseFirestore.instance.collection('Jobs');
                              var docSnapshot = await collection.doc(_JobId).get();
                              if (docSnapshot.exists) {
                                Map<String, dynamic>? data = docSnapshot.data();
                                DocumentReference _docReference=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email);
                                final _refer=_docReference.collection('Applied_Jobs').doc(_JobId);
                                _refer.set({
                                  'Position': data!['Title'],
                                  'Deadline': data['Deadline'],
                                  'Description':data['Description']
                                }
                                );
                                // _refer.doc("hi").add({
                                //   'Event': data!['title'],
                                //   'Date': data['Date']}
                                //  });
                                // _refer.id("hello").add({
                                //       'Event': data!['title'],
                                //       'Date': data['Date']}
                                // });
                                // _refer.add({
                                //   'Event': data!['title'],
                                //    'Date': data['Date']}
                                // );
                                Navigator.of(context).pop();
                              }
                              // final snackBar=SnackBar(
                              //   duration: Duration(days: 365),
                              //   content: Text("Registered !!"),
                              //   action: SnackBarAction(
                              //     label: 'Dismiss',
                              //     onPressed: (){
                              //       Navigator.of(context).pop();
                              //     },
                              //   ),
                              // );
                              Navigator.of(context).pop();
                              // ScaffoldMessenger.of(context).showSnackBar(snackBar);


                            }
                          }


                      ),
                    ),


              ),
            ],
          ),
        ),
      ),


    );
  }
}
