import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './StarRating.dart';

import '../constants/Constants.dart';

class CriticsReviewsSection extends StatelessWidget {
  final Map<String, dynamic> reviewData;

  CriticsReviewsSection({this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(-1.0, 0.0),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        )),
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  reviewData['reviewerImage'] != null
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(reviewData['reviewerImage']),
                          backgroundColor: Colors.white,
                          radius: 30.0,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30.0,
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('${reviewData['reviewerName']}',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                color: Color(Constants.appFontPrimaryColor))),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(children: <Widget>[
                            Text('rated it ',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        Color(Constants.appFontPrimaryColor))),
                            Container(
                                child: IconTheme(
                              data: IconThemeData(
                                color: Colors.amber,
                                size: 20,
                              ),
                              child: StarRating(value: reviewData['stars']),
                            ))
                          ])),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                              reviewData['reviewDate'] != null
                                  ? reviewData['reviewDate']
                                  : '',
                              style: TextStyle(fontSize: 16.0))),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(reviewData['reviewSnippet'],
                  style: TextStyle(fontSize: 16.0)),
            ),
            Container(
                alignment: Alignment(1.0, 0.0),
                child: InkWell(
                  child: Text('Read full review',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 16.0)),
                  onTap: () {
                    launch(reviewData['fullReviewLink']);
                  },
                ))
          ],
        ));
  }
}
