import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:flutter/material.dart';

SnackBar customSnackbar(String content) {
  return SnackBar(
      backgroundColor: AppColors.primaryColor,
      content: Center(child: Text(content)));
}
