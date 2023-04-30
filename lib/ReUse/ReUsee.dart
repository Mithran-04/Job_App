import 'package:flutter/material.dart';
Image logoWidget(String imageName){
  return Image.asset(imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}

SizedBox reUseTextField(String text,IconData icon,bool isPasswordType,
TextEditingController controller){
  return SizedBox(
    width: 360,
    child: TextField(

      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        labelText: text,
        labelStyle: TextStyle(color:Colors.white70,fontSize: 14),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.black87,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0,style: BorderStyle.none)
        )
      ),

      keyboardType: isPasswordType? TextInputType.visiblePassword: TextInputType.emailAddress,

    ),
  );
}

Container signInSignUpButton(
     BuildContext context,bool isLogin,Function onTap) {
  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width-800,
    height: 50,
    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(onPressed: () {
      onTap();
    }, child: Text(
      isLogin ? 'LOGIN' : 'SIGN UP',
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
    ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey;
            }
            return Colors.black26;
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
