import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_fake_store_api/core/network/api.dart';
import 'package:e_commerce_fake_store_api/data/models/categories.dart';
import 'package:http/http.dart' as http;

class CategoriesRepo {
  Future<CategoriesModel?> getAllCategries() async {
    const url = "$baseApi/products/categories";
    try {
      final resp = await http.get(Uri.parse(url));
      if (resp.statusCode == 200) {
        final List<dynamic> body = jsonDecode(resp.body) ;
        final list = (body).cast<String>();
        return CategoriesModel.fromJson(list);
      } else {
        log("here");
        throw Exception("error occured");
      }
    } catch (e) {
      log("error here $e");
      throw Exception("error occured");
    }
  }
}
