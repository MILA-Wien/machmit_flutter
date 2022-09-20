// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

// file which has the getNumberTrivia function
import 'package:frontend_machmit_kern/backend.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:developer' as developer;

void main() {
  group('fetchVersions', () {
    test('Return correct data when http response is successful', () async {
      // Mock the API call to return a json response with http status 200 Ok //
      final mockHTTPClient = MockClient((request) async {
        // Create sample response of the HTTP call //
        final response = {
          "version": "0.0.1",
        };
        return Response(jsonEncode(response), 200);
      });

      var mock = await fetchVersions(mockHTTPClient);
      mock.forEach((key, value) {
        expect(key, "version");
        expect(value, "0.0.1");
      });
      
      expect(await fetchVersions(mockHTTPClient), isA<Map>());
    });

    test(
        'Return HttpException and its message when http response is unsuccessful',
        () async {
      // Mock the API call to return an empty json response with http status 404
      final mockHTTPClient = MockClient((request) async {
        final response = {};
        return Response(jsonEncode(response), 404);
      });
      expect(
          await () => fetchVersions(mockHTTPClient),
          throwsA(predicate((e) =>
              e is HttpException && e.message == 'Failed to load Versions')));
    });
  });
}