import 'dart:convert';
import 'package:digitalsignage/Utils/shared_preferences.dart';
import 'package:digitalsignage/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'Utils/urls.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isProgress = false;
  final user_id_controller=TextEditingController();
  final password_controller=TextEditingController();



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
                  controller: user_id_controller,
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
                  controller: password_controller,
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


                ElevatedButton(onPressed: (){
                  setState(() {
                    isProgress = true;
                  });
                  userLogin();
                },
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


  @override
  void initState() {
    readSharedPreferences(ISLOGIN, "0").then((value) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>home_page()), (Route<dynamic> route) => false);

    });
    super.initState();
  }

  userLogin() async {
    var url = Uri.parse(login);
    Map<String, String> headers = {"Connection": "keep_alive"};
    Map<String, String> body = {"user_id": user_id_controller.text.toString().trim(),"password":password_controller.text.toString().trim()};
    Response response = await post(url, headers: headers, body: body);
    String myData = response.body;
    if(response.statusCode==200){
      var jsonData=jsonDecode(myData);
      if(jsonData["status"]=="success"){
        writeSharedPreferences(ISLOGIN, "1");
        writeSharedPreferences(USERID, jsonData["user_id"]);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>home_page()), (Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: "Login Success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        Fluttertoast.showToast(
            msg: "Wrong user id or password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

}
