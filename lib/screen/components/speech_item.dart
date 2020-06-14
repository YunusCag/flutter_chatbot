import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
enum SpeechType{
  FlameSpeechType,
  UserSpeechType
}
class SpeechItem extends StatelessWidget {
  final String title;
  final DateTime time;
  final SpeechType speechType;



  SpeechItem({Key key,this.title, this.time,this.speechType}):super(key:key);
  var formatter=new DateFormat("jm");
  List<Widget> botMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          child: new Text(
            "F",
            style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold
            ),
          ),backgroundColor: Colors.grey[200], radius: 25,),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text(this.name,
//                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                  )
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Text(
                  title, style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    fontSize: 16
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> userMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
//            Text(this.name, style: Theme.of(context).textTheme.subhead),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)
                )
              ),
              color: Colors.green.shade400,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Text(
                    title, style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    fontSize: 16
                   ),
                  ),
                ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          child: new Text(
            "U",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
        ),backgroundColor: Colors.grey[200], radius: 25,),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.speechType==SpeechType.UserSpeechType ? userMessage(context) : botMessage(context),
      ),
    );
  }
}
