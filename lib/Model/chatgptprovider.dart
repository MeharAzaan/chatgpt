import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class chatprovider extends ChangeNotifier{
  int count = 0;
  List<String>response=[];
  List<String>history=[];
  List<String>input=[];
  bool loading =false;
  Future<bool> sendRequest(String description)async
  {
   // print("sending request");
    loading = true;
    input.add(description);
    notifyListeners();
    final url = Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyDuEh3XJjvQuWJgckY6j5MtH472d_-cu3E");
    final headers = {"content-type":"application/json"};
    final data = jsonEncode(
        {
          "contents": [
            {
              "parts": [
                { "text": description }
              ]
            }
          ]
        }
    );
    final responce = await http.post(url,headers: headers,body: data);
    loading = false;
    notifyListeners();
    if(responce.statusCode==200){
      //print(responce.body);
      final decoded = jsonDecode(responce.body);
      final ans = decoded['candidates'][0]['content']['parts'][0]['text'];
      count++;
      print(ans);
      response.add(ans);
      history.add(description);
      notifyListeners();
    }
    else if(responce.statusCode==400){
      print('error');
    }
    return responce.statusCode==200;
  }
  void emptylist()
  {
    response.clear();
    history.clear();
    input.clear();
    notifyListeners();
  }
}