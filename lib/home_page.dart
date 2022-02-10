 import 'package:flutter/material.dart';


class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width ~/ 260,
              crossAxisSpacing: 10,
            ),
            scrollDirection: Axis.vertical,
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
         padding: EdgeInsets.zero,
         itemCount: 5,
         itemBuilder: (BuildContext context, int index) {
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
                     height: 250,
                     width: 250,
                     decoration: BoxDecoration(
                       color: Colors.red,
                       borderRadius: BorderRadius.circular(5),
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             color: Colors.white,
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

  int rowNumber(){
    int a = MediaQuery.of(context).size.width ~/ 260;
    print(a.toString());
    return a;
  }

}
