import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_fake_store_api/core/network/api.dart';
import 'package:e_commerce_fake_store_api/data/models/item_model.dart';
import 'package:http/http.dart' as http;

class ItemListRepo {
  Future<ItemModel?> fetchItems(String category) async {
    final url = "$baseApi/products/category/$category";
    try {
      final resp = await http.get(Uri.parse(url));
      if (resp.statusCode == 200) {
       
        final body = jsonDecode(resp.body);
        
        return ItemModel.fromJson(body);
      } else {
        log("error while fetching ${resp.body}");
        throw Exception("error occured");
      }
    } catch (e) {
      log("error while fetching catched $e");
      throw Exception("error occured");
    }
  }
}
