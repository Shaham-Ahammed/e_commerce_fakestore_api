import 'package:e_commerce_fake_store_api/data/models/item_model.dart';
import 'package:e_commerce_fake_store_api/data/respositories/cart_repo.dart';
import 'package:e_commerce_fake_store_api/data/sources/hive_cart_collection.dart';
import 'package:flutter/material.dart';

class CartViewmodel extends ChangeNotifier {
  final CartOperations _cartOperations = CartOperations();
  final CartRepo _cartRepo = CartRepo();
  List<Item> _cartItems = [];
  bool _itemAdded = false;
  bool _isLoading = false;

  bool get itemAdded => _itemAdded;
  List<Item> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  
  
  addItemToCart(int id) async {
    _itemAdded = await _cartOperations.addItemToCart(id);
    notifyListeners();
  }
  
  removeItemFromCart(int id)async{
    _isLoading=true;
    await _cartOperations.removeItemFromCart(id);
   final Item deletedItem= _cartItems.where((element) => element.id==id).first;
   _cartItems.remove(deletedItem);
   _isLoading=false;
   notifyListeners();
  }
  
  
  listTheCartItems() async {
    _isLoading = true;
    _cartItems = await _cartRepo.listCartItems();
    _isLoading = false;
    notifyListeners();
  }
}
