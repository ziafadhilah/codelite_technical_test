// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:codelite_test/models/news_model.dart';
import 'package:codelite_test/services/http_services.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt limit = 5.obs;
  late Map<String, dynamic> body;
  RxList<Dashboard> newsModel = <Dashboard>[].obs;

  fetchData() async {
    isLoading.value = true;
    Request request = Request(url: '/');

    request.get().then((response) {
      // var resp = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        newsModel.value =
            jsonResponse.map((e) => Dashboard.fromJson(e)).toList();
        isLoading.value = true;
        // print(newsModel.map((e) => e.title));
      } else {
        isLoading.value = false;
        newsModel.value = [];
        print('Backend error');
      }
    });
  }
}
