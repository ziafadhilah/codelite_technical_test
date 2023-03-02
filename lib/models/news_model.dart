// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

class Dashboard {
  Dashboard({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
    required this.featured,
    required this.launches,
    required this.events,
  });

  int id;
  String title;
  String url;
  String imageUrl;
  String newsSite;
  String summary;
  DateTime publishedAt;
  DateTime updatedAt;
  bool featured;
  List<dynamic> launches;
  List<dynamic> events;

  factory Dashboard.fromRawJson(String str) =>
      Dashboard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        imageUrl: json["imageUrl"],
        newsSite: json["newsSite"],
        summary: json["summary"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        featured: json["featured"],
        launches: List<dynamic>.from(json["launches"].map((x) => x)),
        events: List<dynamic>.from(json["events"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "imageUrl": imageUrl,
        "newsSite": newsSite,
        "summary": summary,
        "publishedAt": publishedAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "featured": featured,
        "launches": List<dynamic>.from(launches.map((x) => x)),
        "events": List<dynamic>.from(events.map((x) => x)),
      };
}
