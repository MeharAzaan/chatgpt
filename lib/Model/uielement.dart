import 'package:flutter/material.dart';

class Uielements {
  static newchatButton(VoidCallback onPressed)
  {
    return ElevatedButton(
        style:ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),onPressed: onPressed
        , child: FittedBox(
      fit: BoxFit.fitHeight,
      child: Padding(
        padding: const EdgeInsets.only(left: 24,right: 24),
        child: Row(
          children: [
            Icon(Icons.add),
            Text('New Chat',softWrap: true,),
          ],
        ),
      ),
    ));
  }
  static void sendRequest(String text){

  }
}