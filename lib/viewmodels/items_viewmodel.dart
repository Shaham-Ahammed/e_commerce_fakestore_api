import 'dart:developer';
import 'package:e_commerce_fake_store_api/data/models/item_model.dart';
import 'package:e_commerce_fake_store_api/data/respositories/item_list_repo.dart';
import 'package:flutter/material.dart';

class ItemsViewmodel extends ChangeNotifier {
  final ItemListRepo _itemListRepo = ItemListRepo();
  ItemModel? _itemModel;
  bool _errorWhileFetching = false;

  bool get errorWhileFetching => _errorWhileFetching;
  ItemModel? get itemModel => _itemModel;
  bool get fetchedItems => _itemModel != null;

  Future<void> fetchItems(String category) async {
    try {
      _itemModel = null;
      notifyListeners();
      _itemModel = await _itemListRepo.fetchItems(category);
      if (_itemModel != null) {
        _errorWhileFetching = false;
        log("items fetched successfully");
      } else {
        _errorWhileFetching = true;
        log("error while fetching items");
      }
    } catch (e) {
      _errorWhileFetching = true;
      log("error while fetching items");
    } finally {
      notifyListeners();
    }
  }
}
