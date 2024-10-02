import 'dart:developer';

import 'package:e_commerce_fake_store_api/data/models/categories.dart';
import 'package:e_commerce_fake_store_api/data/respositories/categories.dart';
import 'package:flutter/material.dart';

class CategoriesViewmodel extends ChangeNotifier {
  CategoriesModel? _categoriesModel;
  final CategoriesRepo _categoriesRepo = CategoriesRepo();
  

  
  bool get categoriesLoaded => _categoriesModel != null;
  CategoriesModel? get categoriesModel => _categoriesModel;

  getAllCategries() async {
    try { _categoriesModel = await _categoriesRepo.getAllCategries();
    if (_categoriesModel != null) {
      log("categories fetched successfully");
    } else {
      log("categories fetch failed");
    }
      
    } catch (e) {
      log("failed fetching cat");
    }finally{
      notifyListeners();
    }
   
  }
}
