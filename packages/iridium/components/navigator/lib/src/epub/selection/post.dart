import 'package:flutter/material.dart';
import 'package:mno_navigator/epub.dart';
import 'package:mno_navigator/publication.dart';
import 'package:mno_navigator/src/epub/selection/selection_popup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostRequestComponent extends StatefulWidget {
  @override
  _PostRequestComponentState createState() => _PostRequestComponentState();
}

class _PostRequestComponentState extends State<PostRequestComponent> {
  bool _isLoading = false;
  String _response = 'Response will appear here';

  void _submitPostRequest(String name, String[] entries) async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse('https://walrus-app-z3kru.ondigitalocean.app/summarise');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "entity": "character",
        "entries": entries,
      }),
    );

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        _response = json.decode(response.body)['message'];
      } else {
        _response = 'Error: ${response.reasonPhrase}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST Request Example'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _submitPostRequest,
              child: Text('Submit POST Request'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_response),
            ),
          ],
        ),
      ),
    );
  }
}
