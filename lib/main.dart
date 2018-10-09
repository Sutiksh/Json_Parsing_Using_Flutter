import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async{
  List _data = await getJson();
   String _body = "";
    _body = _data[0]['body'];
   //for(int i=0;i<_data.length;i++){
  //   print(_data[i]['id']);
  //   }
  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Json Parsing",
          style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w500)
          ),
      ),

      backgroundColor: Colors.grey,
      body: new Center(
        child: new ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context,int position){
              if(position.isOdd) return new Divider();
              final index = position ~/ 2;
              return new ListTile(
                title: new Text("${_data[index]['title']}",
                style: new TextStyle(color: Colors.black,fontSize: 14.5,fontWeight: FontWeight.w400),),

                subtitle: new Text("${_data[index]['body']}",
                  style: new TextStyle(color: Colors.black,fontSize: 14.5,fontWeight: FontWeight.w200),),
                leading: new CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  child: new Text("${_data[index]['id']}",
                    style: new TextStyle(color: Colors.black,fontSize: 14.5,fontWeight: FontWeight.w400),),
                ),
                onTap: (){_showOnTapMessage(context, "${_data[index]['title']}");}
              );
            })
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context, String message){
var alert = new AlertDialog(
  title: new Text('App'),
  content: new Text(message),
  actions: <Widget>[
    new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text('OK'))
  ],
);
showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
    String apiUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);

}