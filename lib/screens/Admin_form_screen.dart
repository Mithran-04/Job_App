import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_validator/string_validator.dart';

class AdminFormScreen extends StatefulWidget {
  const AdminFormScreen({Key? key}) : super(key: key);
  static const routeName = '/Form_ScreenAdmin';

  @override
  State<AdminFormScreen> createState() => _AdminFormScreenState();
}

class _AdminFormScreenState extends State<AdminFormScreen> {
  final formKey = GlobalKey<FormState>();
  final regExp= RegExp(r'^([0-9]{4})-(1[0-2]|0[1-9])-(3[01]|[1-2][0-9]|0?[1-9])$');
  String Title = '';
  String Description = '';
  String phoneNo='';
  String emailId='';
  String Deadline = '';
  String Location='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          // leading: Padding(
          //   padding: EdgeInsets.fromLTRB(14, 30, 10, 20),
          //   // child: BackButton(
          //   //     color: Colors.white,
          //   //   onPressed: (){
          //   //       Navigator.of(context).pop();
          //   //   },
          //   // ),
          // ),
          // floating: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Padding(
              padding: EdgeInsets.fromLTRB(40, 60, 20, 24),
              child: const Text('Enter the details')),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),
          elevation: 1,
          // centerTitle: true,
          backgroundColor: Colors.black,


          // pinned: true,
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
              SizedBox(
                height: 50,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title cannot be empty!';
                  } else {
                    return null;
                  }
                },
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                onSaved: (value) => setState(() => Title = value!),

              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 8,//Normal textInputField will be displayed
                maxLines: 14,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description cannot be empty!';
                  } else {
                    return null;
                  }
                },

                onSaved: (value) => setState(() => Description = value!),
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              const SizedBox(height: 32),
              TextFormField(

                decoration: InputDecoration(
                  labelText: 'Deadline YYYY-MM-DD',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Deadline cannot be empty';
                  }else if(!regExp.hasMatch(value)){
                    return 'Invalid Date format!';
                  }
                  else {
                    return null;
                  }
                },
                onSaved: (value) => setState(() => Deadline = value!),
                keyboardType: TextInputType.datetime,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              const SizedBox(height: 30),

              TextFormField(

                decoration: InputDecoration(
                  labelText: 'Phone No',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone No cannot be empty';
                  }
                  else if(!isNumeric(value))
                    return 'Phone no shoud be numeric';
                  else {
                    return null;
                  }
                },
                onSaved: (value) => setState(() => phoneNo = value!),
                keyboardType: TextInputType.datetime,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              const SizedBox(height: 30),
              TextFormField(

                decoration: InputDecoration(
                  labelText: 'Email ID',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email ID cannot be empty';
                  }
                  else {
                    return null;
                  }
                },
                onSaved: (value) => setState(() => emailId = value!),
                keyboardType: TextInputType.datetime,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              const SizedBox(height: 30),
              TextFormField(

                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18.0),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.amber),
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Location cannot be empty';
                  }
                  else {
                    return null;
                  }
                },
                onSaved: (value) => setState(() => Location = value!),
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              const SizedBox(height: 40),
              Builder(
                builder: (context) => Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO((49), 39, 79, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      // icon: Icon(Icons.app_registration,size: 30,color: Colors.red,),
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                      onPressed: () async {
                        final isValid = formKey.currentState!.validate();
                        FocusScope.of(context).unfocus();

                        if (isValid) {
                          formKey.currentState!.save();
                          CollectionReference _reference =
                          FirebaseFirestore.instance.collection('Jobs');
                          _reference.add({
                            'Title': Title,
                            'Description': Description,
                            'Deadline': Deadline,
                            'phoneNo':phoneNo,
                            'Emailid':emailId,
                            'Location':Location
                          });

                          Navigator.of(context).pop();
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
