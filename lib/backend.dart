import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class Backend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BackendState();
  }
}

class BackendState extends State<Backend> {
  late Future<Map<String, dynamic>> getVersion;

  @override
  void initState() {
    super.initState();
    getVersion = fetchVersions();
  }

  Future<Map<String, dynamic>> fetchVersions() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/core/version/?format=json'));
    if (response.statusCode == 200) {
      var getVersion = json.decode(response.body);
      developer.log(
        'response.string',
        name: 'backend.api.call',
        error: jsonEncode(getVersion),
      );
      return getVersion;
    } else {
      throw Exception('Failed to load Versions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
      future: getVersion,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
              itemBuilder: (context, index) {
                var version = (snapshot.data as Map<String, dynamic>);
                String display = '';
                version.forEach((key, value) {
                  display = 'Key = $key : Value = $value';
                });
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        display,
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
              itemCount: (snapshot.data as Map<String, dynamic>).length);
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
        );
      },
    ));
  }
}
