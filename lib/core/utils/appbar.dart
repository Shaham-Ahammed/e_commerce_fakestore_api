import 'package:e_commerce_fake_store_api/core/utils/font.dart';
import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:e_commerce_fake_store_api/view/screens/carts.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(String heading, bool back, BuildContext context,
    [bool trailing = false]) {
  return AppBar(
    leading: back == true
        ? IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.whiteColor,
          )
        : const SizedBox(),
    backgroundColor: AppColors.primaryColor,
    title: AppFont(
      heading,
      size: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.whiteColor,
    ),
    actions: [
      if (trailing)
        IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CartScreen(),
          )),
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.whiteColor,
          ),
        )
    ],
  );
}
