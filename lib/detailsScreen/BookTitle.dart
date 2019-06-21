import 'package:flutter/material.dart';

import '../constants/Constants.dart';

class BookTitle extends StatelessWidget {
  final Map<String, dynamic> bookTitleData;

  BookTitle({this.bookTitleData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10.0),
            child: Text(bookTitleData['title'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0,color: Color(Constants.appFontPrimaryColor))),
            alignment: Alignment(0.0, 0.0)),
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text('by ${bookTitleData['author']}',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0,color: Color(Constants.appFontPrimaryColor))),
        )
      ],
    );
  }
}
