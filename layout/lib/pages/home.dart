import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Homepage extends StatefulWidget {
  //const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BURGER"),
      ),
     body: Padding(
          padding: EdgeInsets.all(20),
          child: FutureBuilder( builder: (context,AsyncSnapshot snapshot) {
              //var data = json.decode(snapshot.data.toString()); // 
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                    return MyBox(snapshot.data[index]['title'], snapshot.data[index]['subtitle'], snapshot.data[index]['image_url'],snapshot.data[index]['detail']);
                
                },
                itemCount: snapshot.data.length, );

          },
          future:  getData(),
          //future: DefaultAssetBundle.of(context).loadString('assets/data.json'), 


        )
    ));
  }
Widget MyBox(String title, String subtitle, String image_url, String detail) {
  var v1,v2,v3,v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;    
  return Container(
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.all(20),
    //color: Colors.yellow[300],
    height: 150,
    decoration: BoxDecoration(
      //color: Colors.yellow[300],
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: NetworkImage(
          image_url),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.20), BlendMode.darken)
      ),
    ),
     child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(height: 18),
          TextButton(onPressed: () {
              print("Next Page >>>");
              Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(v1,v2,v3,v4)));

          }, child: Text("อ่านต่อ"))
        ],
      ),
    );
  }


Future getData() async {
  //https://raw.githubusercontent.com/jiejieji/BasicAPI/main/data.json
  var url = Uri.https('raw.githubusercontent.com','jiejieji/BasicAPI/main/data.json');
  var response = await http.get(url);
  var result = json.decode(response.body);
  return result; 
}

}





