import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_fake_store_api/core/constants/hive_box.dart';
import 'package:e_commerce_fake_store_api/core/network/api.dart';
import 'package:e_commerce_fake_store_api/data/models/item_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CartRepo {
  Future<List<Item>> listCartItems() async {
    final box = Hive.box(boxName);
    var data = await box.get(itemsKeyHive);
    List<Item> items=[];
    if (data is List<int>) {
      for (var ele in data) {
        final url = "$baseApi/products/$ele";
        try {
          final resp = await http.get(Uri.parse(url));
          final product = Item.fromJson(jsonDecode(resp.body));
          items.add(product);
        } catch (e) {
          log("error while carting");
          throw Exception("error");
        }
      }
      return items;
    } else {
      return [];
    }
  }
}
