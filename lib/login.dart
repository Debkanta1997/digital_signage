import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isProgress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Color(0Xffa4c4b5),
            borderRadius: BorderRadius.circular(5)
          ),

          width: MediaQuery.of(context).size.height * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Digital Signage Login",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
                  ],
                ),
                SizedBox(height: 50,),


                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text("Enter User ID",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
                ),
                TextField(
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.0),),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.0),),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    isDense: true,
                    hintText: "User ID",
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5)),
                  ),
                  cursorColor: Colors.red,

                ),




                SizedBox(height: 20,),


                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text("Enter Password",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
                ),
                TextField(
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.0),),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.0),),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    isDense: true,
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5)),
                  ),
                  cursorColor: Colors.red,

                ),


                SizedBox(height: 40,),


                ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        primary: isProgress ? Color(0Xff696969).withOpacity(0.5) : Color(0Xff696969)
                    ),
                    child: Container(
                        height: 38,
                        child: Center(
                          child: Text(isProgress ? "Logging in..." :"LOG IN",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                        )
                    ))


              ],
            ),
          )
        ),
      ),
    );
  }
}
