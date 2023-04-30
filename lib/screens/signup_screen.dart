import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_app/ReUse/ReUsee.dart';
import 'package:job_app/screens/signin_screen.dart';
import 'package:job_app/screens/HomeScreen.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  String Name='';
  String Emailid = '';
  String Password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Sign up",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(padding: EdgeInsets.fromLTRB(20,
            MediaQuery.of(context).size.height*0.1, 20, 0),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: 350,
                  child: Form(
                      key:formKey,
                      child: ListView(
                        padding: EdgeInsets.all(14),
                        children: [
                          TextFormField(
                            cursorColor: Colors.white,

                            style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: 16),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle_sharp,
                                  color: Colors.white70,
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(color:Colors.white70,fontSize: 14),
                                filled: true,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                fillColor: Colors.black87,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                )
                            ),

                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name cannot be empty!';
                              }
                              else {
                                return null;
                              }
                            },

                            onSaved: (value) => setState(() => Name = value!),

                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            cursorColor: Colors.white,

                            style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: 16),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle_sharp,
                                  color: Colors.white70,
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(color:Colors.white70,fontSize: 14),
                                filled: true,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                fillColor: Colors.black87,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                )
                            ),

                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email id cannot be empty!';
                              } else if(!value.contains('@') || !value.contains('com') || !value.contains('co')) {
                                return 'Invalid email id';
                              }
                              else {
                                return null;
                              }
                            },

                            onSaved: (value) => setState(() => Emailid = value!),

                          ),
                          const SizedBox(height: 20),
                          TextFormField(

                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: 16),
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white70,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.lock_outlined,
                                  color: Colors.white70,
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color:Colors.white70,fontSize: 14),
                                filled: true,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                fillColor: Colors.black87,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                )
                            ),

                            keyboardType:TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty!';
                              } else if(value.length<6) {
                                return 'Password must be at least 6 characters';
                              }
                              else {
                                return null;
                              }
                            },

                            onSaved: (value) => setState(() =>Password = value!),

                          ),
                          SizedBox(height: 40,),
                          signInSignUpButton(context, false, (){
                            final isValid = formKey.currentState!.validate();
                            FocusScope.of(context).unfocus();

                            if (isValid) {
                              formKey.currentState!.save();
                              FirebaseAuth.instance.createUserWithEmailAndPassword(email: Emailid,password: Password).then((value){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
                              }).onError((error, stackTrace){
                               openDialogOut(error.toString());
                              });

                            }
                          }
                          ),
                        ],
                      )

                  ),
                ),
              ),


            ],
          ),),
      ),

    );
  }
  Future openDialogOut(String error) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(fontSize: 17),
        ),
        content: error.contains('email address is already in use')? Text('Email id already exist!!',style: TextStyle(fontSize: 14),):Text('Please check your Internet connection and try again',style: TextStyle(fontSize: 14),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      ));

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
