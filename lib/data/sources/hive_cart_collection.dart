import 'dart:developer';
import 'package:e_commerce_fake_store_api/core/constants/hive_box.dart';
import 'package:hive/hive.dart';

class CartOperations {
  Future<bool> addItemToCart(int id) async {
    final box = Hive.box(boxName);
    var items = box.get(itemsKeyHive);
    if (items is List<int>) {
      if (!items.contains(id)) {
        items.add(id);
        await box.put(itemsKeyHive, items);
        return true;
      } else {
        return false;
      }
    } else {
      List<int> newList = [id];
      await box.put(itemsKeyHive, newList);
      log("New list created and item added: $newList");
      return true;
    }
  }

  removeItemFromCart(int id) async {
    var box = Hive.box(boxName);
    List<int> items = box.get(itemsKeyHive);
    items.remove(id);
    await box.put(itemsKeyHive, items);
  }
}
