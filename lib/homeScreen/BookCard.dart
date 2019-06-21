import 'package:flutter/material.dart';

import '../detailsScreen/DetailsScreen.dart';
import '../constants/Constants.dart';

class BookCard extends StatelessWidget {
  final Map<String, dynamic> bookData;

  BookCard({this.bookData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsScreen(bookTitleParam: bookData['title'])),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              color: Color(Constants.boxCardBackgroundColor)),
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(bookData['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600,color: Color(Constants.appFontPrimaryColor))),
                        Text('by ${bookData['author']}',
                            style: TextStyle(fontSize: 18.0))
                      ],
                    ),
                  ))
                ],
              ),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(bookData['review_publication_logo']),
                    backgroundColor: Colors.transparent,
                    radius: 25.0,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(bookData['review_snippet'],
                            style: TextStyle(fontSize: 15.0))
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
