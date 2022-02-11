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
        child:
        GridView.count(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            padding: EdgeInsets.symmetric(horizontal: 5),
            crossAxisCount: MediaQuery.of(context).size.width ~/ 260,
            crossAxisSpacing: 10,
            children:  List.generate(video_lists.length, (index) {
              _controller = VideoPlayerController.network(video_lists[index].signageUrl.toString(),
              );
              _controller.addListener(() {
                setState(() {});
              });
              _controller.setLooping(false);
              _controller.initialize();
              return Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black87,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    var picked = await FilePicker.platform.pickFiles();
                                    if (picked != null) {
                                      print(picked.files.first.name);
                                      objFile = picked.files.single;
                                    }
                                  },
                                  child: Text('Change')),
                              ElevatedButton(
                                  onPressed: () {}, child: Text('Delete'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),

        // GridView.builder(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: MediaQuery.of(context).size.width ~/ 260,
        //       crossAxisSpacing: 10,
        //     ),
        //     scrollDirection: Axis.vertical,
        //  shrinkWrap: true,
        //  physics: NeverScrollableScrollPhysics(),
        //  padding: EdgeInsets.zero,
        //  itemCount: 5,
        //  itemBuilder: (BuildContext context, int index) {
        //    return Wrap(
        //      direction: Axis.vertical,
        //      spacing: 10.0,
        //      runSpacing: 20.0,
        //      children: [
        //        Padding(
        //          padding: const EdgeInsets.only(top: 10,),
        //          child: Card(
        //            elevation: 5, shadowColor: Colors.black87,
        //            child: Container(
        //              padding: EdgeInsets.all(10),
        //              height: 250,
        //              width: 250,
        //              decoration: BoxDecoration(
        //                color: Colors.red,
        //                borderRadius: BorderRadius.circular(5),
        //              ),
        //              child: Column(
        //                mainAxisAlignment: MainAxisAlignment.start,
        //                crossAxisAlignment: CrossAxisAlignment.start,
        //                children: [
        //                  Expanded(
        //                    child: Container(
        //                      color: Colors.white,
        //                    ),
        //                  ),
        //                  Padding(
        //                    padding: const EdgeInsets.only(top: 10),
        //                    child: Row(
        //                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                      crossAxisAlignment: CrossAxisAlignment.end,
        //                      children: [
        //                        ElevatedButton(
        //                            onPressed: () {},
        //                            child: Text('Change')
        //                        ),
        //                        ElevatedButton(
        //                            onPressed: () {},
        //                            child: Text('Delete')
        //                        )
        //                      ],
        //                    ),
        //                  ),
        //                ],
        //              ),
        //            ),
        //          ),
        //        ),
        //      ],
        //    );
        //  }
        // ),
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
    if(jsonData["status"]=="video found") {
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
