import 'package:flutter/material.dart';

import '../detailsScreen/DetailsScreen.dart';
import '../constants/Constants.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchBarState();
  }
}

class SearchBarState extends State<SearchBar> {
  final userTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DetailsScreen(bookTitleParam: userTextController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextField(
        onSubmitted: (str) => _onPressed(),
        controller: userTextController,
        decoration: InputDecoration(
            hintText: 'Search for a book or author...',
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 9.5, horizontal: 10)),
      )),
      RaisedButton(
        onPressed: _onPressed,
        textColor: Color(Constants.appFontPrimaryColor),
        color: Color(Constants.appPrimaryColor),
        child: const Text('Search', style: TextStyle(fontSize: 20)),
      )
    ]);
  }
}
