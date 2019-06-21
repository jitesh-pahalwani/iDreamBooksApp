import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './BookTitle.dart';
import './BookRatingsSection.dart';
import './BookInfoSection.dart';
import './CriticsReviewsSection.dart';

import '../constants/Constants.dart';

class DetailsScreen extends StatefulWidget {
  final String bookTitleParam;

  DetailsScreen({this.bookTitleParam});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsScreenState();
  }
}

class DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Map<String, dynamic>> fetchDetails() async {
    final response = await http.get(
        "${Constants.baseURL}${Constants.bookReviewsUrlExtension}${widget.bookTitleParam}&key=${Constants.APIKey}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Widget getReviewWidgets(List<dynamic> reviewItem) {
    return new Column(
        children: reviewItem
            .map((item) => CriticsReviewsSection(reviewData: {
                  'reviewerImage': item['source_logo'],
                  'reviewerName': item['source'],
                  'reviewDate': item['review_date'],
                  'reviewSnippet': item['snippet'],
                  'fullReviewLink': item['review_link'],
                  'stars': item['star_rating']
                }))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color:
                Color(Constants.appFontPrimaryColor), //change your color here
          ),
          title: Text('Book Reviews',
              style: TextStyle(color: Color(Constants.appFontPrimaryColor))),
          backgroundColor: Color(Constants.appPrimaryColor),
        ),
        body: FutureBuilder(
            future: fetchDetails(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['total_results'] == 1) {
                  return ListView(children: [
                    BookTitle(bookTitleData: {
                      'title': snapshot.data['book']['title'],
                      'author': snapshot.data['book']['author']
                    }),
                    BookRatingsSection(bookRatingsData: {
                      'rating': snapshot.data['book']['rating'],
                      'reviewCount': snapshot.data['book']['review_count']
                    }),
                    BookInfoSection(bookInfoData: {
                      'genre': snapshot.data['book']['genre'],
                      'pageCount': snapshot.data['book']['pages'],
                      'reviewDate': snapshot.data['book']['release_date']
                    }),
                    Container(
                      alignment: Alignment(0.0, 0.0),
                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical:10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: Text('CRITIC REVIEWS',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600,color: Color(Constants.appFontPrimaryColor))),
                    ),
                    Container(
                      height: 2.0,
                      margin: EdgeInsets.symmetric(horizontal: 150.0),
                      color: Colors.grey,
                    ),
                    getReviewWidgets(snapshot.data['book']['critic_reviews'])
                  ]);
                } else {
                  return Center(
                      child: Text('No results found. Please try again.',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600)));
                }
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
