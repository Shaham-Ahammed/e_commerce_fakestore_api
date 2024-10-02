import 'package:e_commerce_fake_store_api/core/constants/hive_box.dart';
import 'package:e_commerce_fake_store_api/view/screens/categories.dart';
import 'package:e_commerce_fake_store_api/view/screens/login.dart';
import 'package:e_commerce_fake_store_api/viewmodels/cart_viewmodel.dart';
import 'package:e_commerce_fake_store_api/viewmodels/categories_viewmodel.dart';
import 'package:e_commerce_fake_store_api/viewmodels/items_viewmodel.dart';
import 'package:e_commerce_fake_store_api/viewmodels/users_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(boxName);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ItemsViewmodel()),
      ChangeNotifierProvider(
        create: (context) => UsersViewmodel(),
      ),
      ChangeNotifierProvider(
        create: (context) => CategoriesViewmodel(),
      )
      ,
       ChangeNotifierProvider(
        create: (context) => CartViewmodel(),
      )
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoriesScreen(),
    ),
  ));
}
