// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:codelite_test/controllers/news_controller.dart';
import 'package:codelite_test/views/detail.dart';
import 'package:codelite_test/views/detail_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main(List<String> args) {
  runApp(GetMaterialApp(
    home: News(),
  ));
}

// ignore: use_key_in_widget_constructors, must_be_immutable
class News extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('News Application Using GetX'),
      ),
      body: Obx(
        () => newsController.isLoading.value
            ? ListView.builder(
                itemCount: newsController.newsModel.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: newsController
                                          .newsModel[index].imageUrl ==
                                      null
                                  ? Icon(Icons.image)
                                  : Image.network(
                                      newsController.newsModel[index].imageUrl,
                                      width: 100,
                                    ),
                              title: Text(
                                newsController.newsModel[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18),
                              ),
                              subtitle: Text(
                                newsController.newsModel[index].summary,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              // onTap: () {
                              //   // _launchInBrowser(Uri.parse(
                              //   //     newsController.newsModel[index].url));
                              //   Get.to(
                              //     NewsDetail(),
                              //     arguments:
                              //         newsController.newsModel[index].url,
                              //   );
                              // },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text("Published At: ",
                                    style: TextStyle(color: Colors.black45)),
                                Text(
                                  DateFormat.yMMMd().format(newsController
                                      .newsModel[index].publishedAt),
                                  style: TextStyle(color: Colors.black45),
                                ),
                                // Text(newsController.newsModel[index].publishedAt
                                //     .toString()),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(
                                        NewsDetail(),
                                        arguments:
                                            newsController.newsModel[index].url,
                                      );
                                    },
                                    child: Text("WEB VIEW"),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(NewsDetailApp(), arguments: [
                                        //0
                                        newsController.newsModel[index].title,
                                        //1
                                        newsController.newsModel[index].summary,
                                        //2
                                        newsController
                                            .newsModel[index].publishedAt,
                                        //3
                                        newsController
                                            .newsModel[index].imageUrl,
                                        //4
                                        newsController.newsModel[index].url,
                                        //5
                                        newsController
                                            .newsModel[index].newsSite,
                                      ]);
                                    },
                                    child: Text("APP VIEW"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
