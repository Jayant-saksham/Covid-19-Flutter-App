import 'package:flutter/material.dart';

class myCard extends StatelessWidget {
  String data;
  String belowText;
  Color textColor;
  myCard({this.data, this.belowText, this.textColor});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        width: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/25,),
            Center(
              child: Text(
                "${data}",
                style: TextStyle(
                    color: textColor, fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/35,),
            Center(
              child: Text(
                '$belowText',
                style: TextStyle(
                  color: Colors.grey, 
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
