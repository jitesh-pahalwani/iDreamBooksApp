import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './SearchBar.dart';
import './BookCard.dart';

import '../constants/Constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String currentGenreValue = 'all-books';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> fetchRecos(currentGenreValue) async {
    final response = await http.get(
        '${Constants.baseURL}${Constants.recentRecommendationUrlExtension}${Constants.APIKey}&slug=$currentGenreValue');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text('iDreamBooks App',
                  style:
                      TextStyle(color: Color(Constants.appFontPrimaryColor)))),
          backgroundColor: Color(Constants.appPrimaryColor),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SearchBar(),
            ),
            Container(
              child: Text('Recent recommendations',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Color(Constants.appFontPrimaryColor))),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(children: [
                Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Genre',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color(Constants.appFontPrimaryColor))),
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                  decoration: BoxDecoration(
                      color: Color(Constants.appPrimaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: DropdownButton<String>(
                    value: currentGenreValue,
                    onChanged: (String newValue) async {
                      setState(() {
                        currentGenreValue = newValue;
                        isLoading = true;
                      });
                      await fetchRecos(currentGenreValue);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    items: Constants.allGenres.entries
                        .map<DropdownMenuItem<String>>(
                            (MapEntry<String, String> e) {
                      return DropdownMenuItem<String>(
                        value: e.key,
                        child: Text(e.value),
                      );
                    }).toList(),
                  ),
                )
              ]),
            ),
            Container(
              child: FutureBuilder(
                  future: fetchRecos(currentGenreValue),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!isLoading) {
                      if (snapshot.hasData) {
                        return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return BookCard(
                                      bookData: snapshot.data[index]);
                                }));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    }
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 150),
                        child: CircularProgressIndicator());
                  }),
            )
          ],
        ));
  }
}
