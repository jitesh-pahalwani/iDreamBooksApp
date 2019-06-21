import 'package:flutter/material.dart';

import '../constants/Constants.dart';

class BookRatingsSection extends StatelessWidget {
  final Map<String, dynamic> bookRatingsData;

  BookRatingsSection({this.bookRatingsData});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        )),
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: (bookRatingsData['rating'] != null
                  ? Text('${bookRatingsData['rating']}% rating',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(Constants.appFontPrimaryColor)))
                  : Text('No rating',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(Constants.appFontPrimaryColor)))),
            ),
            Container(
              child: Text('${bookRatingsData['reviewCount']} reviews',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(Constants.appFontPrimaryColor))),
            )
          ],
        ));
  }
}
