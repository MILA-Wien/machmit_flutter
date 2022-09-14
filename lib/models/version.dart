
class Version {
  String version;

  Version({this.version});

  factory Version.fromJSON(Map<String, dynamic> parsedJson) {
    return Version(
        version: parsedJson['version'],
        );
  }
}