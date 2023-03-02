// ignore_for_file: prefer_const_constructors

import 'package:codelite_test/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailApp extends StatefulWidget {
  @override
  State<NewsDetailApp> createState() => _NewsDetailAppState();
}

class _NewsDetailAppState extends State<NewsDetailApp> {
  dynamic data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Detail Pages"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                child: Text(
                  data[0],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Published at ',
                      style: TextStyle(fontSize: 18, color: Colors.black45),
                    ),
                    Text(
                      DateFormat.yMMMd().format(data[2]),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                child: Image.network(data[3]),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                child: Text(
                  data[1],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  "News site: ${data[5]}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextButton(
                  onPressed: () {
                    _launchInBrowser(Uri.parse(data[4]));
                  },
                  child: Text(
                    "Source: ${data[4]}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                // child: Text(
                //   "Source : ${data[4]}",
                //   textAlign: TextAlign.justify,
                //   style: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
              )
            ],
          ),
        ));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
