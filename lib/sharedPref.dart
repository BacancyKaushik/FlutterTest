import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:testapiproject/models/modelclass.dart';

class SharedPref
{


  static const String key = 'myModel';

  static Future<void> saveMyModel(List<ModelClass> myModel) async
  {
    final prefs = await SharedPreferences.getInstance();
    final modelList = myModel.map((model) => model.toJson()).toList();
    String sampleStringList = jsonEncode(modelList);

    await prefs.setString('myModel', sampleStringList);
  }

  static Future<List<ModelClass>?>  getMyModel() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      List<ModelClass> sampleListFromPreferance = List<ModelClass>.from(jsonMap.map((x) => ModelClass.fromJson(x)));

      return sampleListFromPreferance;
    }
    return null;
  }



}