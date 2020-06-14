import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  SharedPreferences _sharedPreferences;
  final String _firsTimeKey="FIRST_TIME";

  SharedPref._internal();
  static final SharedPref _instance=SharedPref._internal();
  factory SharedPref(){
    return _instance;
  }
  Future<bool> getFirstTime()async{
    _sharedPreferences=await SharedPreferences.getInstance();
    bool firstTime=_sharedPreferences.getBool(_firsTimeKey);
    if(firstTime==null){
      firstTime=true;
    }
    return firstTime;
  }
  Future<void> setFirstTime(bool first)async{
    _sharedPreferences=await SharedPreferences.getInstance();
    _sharedPreferences.setBool(_firsTimeKey,first);
  }
  void dispose(){
    _sharedPreferences.clear();
  }

}