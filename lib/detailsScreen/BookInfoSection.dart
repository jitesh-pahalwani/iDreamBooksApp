import 'package:flutter/material.dart';

import '../constants/Constants.dart';

class BookInfoSection extends StatelessWidget {
  final Map<String, dynamic> bookInfoData;

  BookInfoSection({this.bookInfoData});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        )),
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Text(bookInfoData['genre'],
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(Constants.appFontPrimaryColor))),
            ),
            Container(
              child: bookInfoData['pageCount'] != null ? Text('${bookInfoData['pageCount']} pages',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(Constants.appFontPrimaryColor))) : null,
            ),
            Container(
              child: bookInfoData['reviewDate'] != null ? Text(bookInfoData['reviewDate'],
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(Constants.appFontPrimaryColor))) : null,
            )
          ],
        ));
  }
}
