// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:codelite_test/models/news_model.dart';
import 'package:codelite_test/services/http_services.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  RxBool isLoading = true.obs;
  late Map<String, dynamic> body;
  RxList<Dashboard> newsModel = <Dashboard>[].obs;

  RxInt id = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    Request request = Request(url: '/');

    request.get().then((value) {
      if (value.statusCode == 200) {
        List jsonResponse = jsonDecode(value.body);
        newsModel.value =
            jsonResponse.map((e) => Dashboard.fromJson(e)).toList();
        // print(newsModel.map((e) => e.title));
      } else {
        print('Backend error');
      }
    });
  }
}
