import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/version.dart';

class Backend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BackendState();
  }
}

class BackendState extends State<Backend> {
  Future<List<Version>> listVersions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listVersions = fetchVersions();
  }

  Future<List<Version>> fetchVersions() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/Versions'));
    if (response.statusCode == 200) {
      var getVersionsData = json.decode(response.body) as List;
      var listVersions = getVersionsData.map((i) => Version.fromJSON(i)).toList();
      return listVersions;
    } else {
      throw Exception('Failed to load Versions');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder<List<Version>>(
      future: listVersions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
              itemBuilder: (context, index) {
                var version = (snapshot.data as List<Version>)[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        version.version,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: (snapshot.data as List<Version>).length);
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyanAccent,
          ),
        );
      },
    ));
  }
}