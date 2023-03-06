// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, unrelated_type_equality_checks, unnecessary_null_comparison, unused_import

import 'package:codelite_test/controllers/news_controller.dart';
import 'package:codelite_test/views/detail.dart';
import 'package:codelite_test/views/detail_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class News extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());
  News({super.key});

  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsController.fetchData();
    });
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text('News Application Using GetX'),
        ),
        body: Obx(() {
          return newsController.isLoading == true
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.builder(
                    padding: EdgeInsets.all(12.0),
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
                                          newsController
                                              .newsModel[index].imageUrl,
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
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text("Published At: ",
                                        style:
                                            TextStyle(color: Colors.black45)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(
                                            NewsDetail(),
                                            arguments: newsController
                                                .newsModel[index].url,
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
                                            newsController
                                                .newsModel[index].title,
                                            //1
                                            newsController
                                                .newsModel[index].summary,
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
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }));
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    newsController.fetchData();
    newsController.limit.value = 5;
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    newsController.limit = newsController.limit + 5;

    _refreshController.loadComplete();
  }
}
