 import 'dart:convert';
import 'package:digitalsignage/Utils/shared_preferences.dart';
import 'package:digitalsignage/Utils/urls.dart';
import 'package:digitalsignage/videoList.dart';
import 'package:flutter/material.dart';
 import 'package:http/http.dart';
 import 'package:file_picker/file_picker.dart';
 import 'package:video_player/video_player.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
List<VideoList> video_lists = [];
bool isLoading =true;
String user_id="";
PlatformFile? objFile = null;
late VideoPlayerController _controller;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.green,),
            SizedBox(height: 10,),
            Text("Loading...",style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.green))
          ],
        ),
      ) :SingleChildScrollView(
        child:GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width ~/ 260,
              crossAxisSpacing: 10,
            ),
            scrollDirection: Axis.vertical,
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
         padding: EdgeInsets.zero,
         itemCount: video_lists.length,
         itemBuilder: (BuildContext context, int index) {
           _controller = new VideoPlayerController.network(video_lists[index].signageUrl.toString(),
                   );
                   _controller.addListener(() {
                   });
                   _controller.setLooping(false);
                   _controller.initialize();

           return Wrap(
             direction: Axis.vertical,
             spacing: 10.0,
             runSpacing: 20.0,
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 10,),
                 child: Card(
                   elevation: 5, shadowColor: Colors.black87,
                   child: Container(
                     padding: EdgeInsets.all(10),
                     height: 200,
                     width: 250,
                     decoration: BoxDecoration(
                       color: Colors.grey.shade400,
                       borderRadius: BorderRadius.circular(5),
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             color: Colors.white,
                             child: Stack(
                                 children: [

                                   VideoPlayer(_controller),
                                   Center(
                                     child: InkWell(
                                       onTap: () {
                                         //setState(() {
                                           if (_controller.value.isPlaying) {
                                             _controller.pause();
                                             video_lists[index].isPlaying=false;
                                           } else {
                                             _controller.play();
                                             video_lists[index].isPlaying=true;
                                           }
                                        // });

                                       },
                                       // Display the correct icon depending on the state of the player.
                                       child: Icon(
                                         video_lists[index].isPlaying==true ? Icons.pause : Icons.play_arrow,
                                         color: Colors.blue,
                                       ),
                                     )
                                   ),
                                 ]),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(top: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               ElevatedButton(
                                   onPressed: () {},
                                   child: Text('Change')
                               ),
                               ElevatedButton(
                                   onPressed: () {},
                                   child: Text('Delete')
                               )
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ],
           );
         }
        ),
      ),
    );
  }


  @override
  void initState() {
    readSharedPreferences(USERID, "").then((value) {
      user_id = value;
      getAllVideos();
    });
    super.initState();
  }

  getAllVideos() async {
    var url = Uri.parse(get_all_video);
    Map<String, String> headers = {"Connection": "keep_alive"};
    Map<String, String> body = {"user_id": user_id};
    Response response = await post(url, body: body, headers: headers);
    String myData = response.body;
    var jsonData=jsonDecode(myData);
    if(jsonData["status"]=="video found"
        "") {
      jsonData['video_list'].forEach((jsonResponse) {
        VideoList obj = new VideoList.fromJson(jsonResponse);
        video_lists.add(obj);
      });
    }

    setState(() {
      isLoading=false;
    });
  }

}
