import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutterchatbot/screen/components/speech_item.dart';
import 'package:flutterchatbot/screen/listen_speech_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<SpeechItem> messageList=<SpeechItem>[];
  final TextEditingController _textController=new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String message;
  final stt.SpeechToText speech=stt.SpeechToText();

  bool _hasSpeech=false;
  bool _stressTest = false;
  double level = 0.0;
  int _stressLoops = 0;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];


  VoiceController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    controller = FlutterTextToSpeech.instance.voiceController();
    controller.setLanguage("tr-TR");
    controller.init();

     */
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFE9E9E9),
      appBar: AppBar(
        title: Text("Flame Sohbet Robotu"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context,index){
                return Divider(height: 0,thickness: 0,color: Colors.transparent,);
              },
              itemBuilder: (context,index){
              return messageList[index];
            },reverse: true,itemCount: messageList.length,),
          ),
          Card(
            color: Colors.white.withOpacity(.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          controller: _textController,
                          validator: (input){
                            if(input.length<2){
                              return "Geçerli bir mesaj giriniz.";
                            }else{
                              return null;
                            }
                          },
                          //onSaved: _getUserTextInput,
                          decoration: InputDecoration.collapsed(hintText: "Bir mesaj giriniz."),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                          icon: Icon(Icons.mic, color: Colors.green[400],),
                          onPressed:()=>_getUserVoiceInput()
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                          icon: Icon(Icons.send, color: Colors.green[400],),
                          onPressed:()=>_getUserTextInput(_textController.text)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _getUserTextInput(String text) {
    if(_formKey.currentState.validate()){
      _textController.clear();
      SpeechItem speechItem=new SpeechItem(
        title: text,
        time: DateTime.now(),
        speechType: SpeechType.UserSpeechType,

      );
      setState(() {
        messageList.insert(0, speechItem);
      });
      agentResponse(text);

    }
  }

  _getUserVoiceInput() async{
    String userVoiceMessage=await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListenSpeechScreen()));
    print("User Voice Input:$userVoiceMessage");
    if(userVoiceMessage.isNotEmpty&&userVoiceMessage!=null){
      SpeechItem speechItem=SpeechItem(
        title: userVoiceMessage,
        time: DateTime.now(),
        speechType: SpeechType.UserSpeechType,
      );
      setState(() {
        messageList.insert(0,speechItem);
      });
      agentResponse(userVoiceMessage);
    }

  }

  void agentResponse(String query) async {
    try{
      AuthGoogle authGoogle =
      await AuthGoogle(fileJson: "assets/dialogflow.json").build();
      Dialogflow dialogFlow =
      Dialogflow(authGoogle: authGoogle, language: Language.english);
      AIResponse response = await dialogFlow.detectIntent(query);

      SpeechItem speechItem=new SpeechItem(
        title: response.getMessage()?? CardDialogflow(response.getListMessage()[0]).title,
        speechType: SpeechType.FlameSpeechType,
        time: DateTime.now(),
      );
      setState(() {
        messageList.insert(0, speechItem);
      });

    }catch(e){
      print(e.toString());
    }
  }
}
