import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_app/ReUse/ReUsee.dart';
import 'package:job_app/screens/Admin_job_list.dart';
import 'package:job_app/screens/signup_screen.dart';
import 'package:job_app/screens/LandingScreen.dart';
import 'package:job_app/screens/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SignInScreen extends StatefulWidget {
  static const routeName = '/SignIn-screen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();

  String Emailid = '';
  String Password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(padding: EdgeInsets.fromLTRB(20,
            MediaQuery.of(context).size.height*0.1, 20, 0),
          child: Column(
            children: [
              logoWidget("assets/images/UserLogo.png"),
              Expanded(
                child: SizedBox(
                  width: 380,
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
                              return 'password must be at least 6 characters';
                            }
                            else {
                              return null;
                            }
                          },

                          onSaved: (value) => setState(() =>Password = value!),

                        ),
                      ],
                    )

                  ),
                ),
              ),
              signInSignUpButton(context, true, (){
                final isValid = formKey.currentState!.validate();
                FocusScope.of(context).unfocus();

                if (isValid) {
                  formKey.currentState!.save();
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: Emailid, password:Password).then(
                          (value){
                        if(FirebaseAuth.instance.currentUser!.email!.contains("admin123@gmail.com"))
                          Navigator.of(context).pushNamed(AdminHomeScreen.routeName);
                        else
                          Navigator.of(context).pushNamed(LandingScreen.routeName);

                      }
                  ).onError((error, stackTrace){
                    openDialogOut(error.toString());
                  });

                }
              }
              ),
              signUpOption(),
              SizedBox(height: 30,),

            ],
          ),),
      ),

    );
  }

  Row signUpOption(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text("Don't have account?",
            style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
            },
            child: Text(
              "  Sign Up",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
            ),
          )
        ]

    );
  }
  Future openDialogOut(String error) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(fontSize: 17),
        ),
        content:error.contains("password is invalid")?Text("Incorrect password!!",style: TextStyle(fontSize: 14),):Text("Email id does not exist!!",style: TextStyle(fontSize: 14),),
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


