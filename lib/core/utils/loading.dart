import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Make dialog transparent
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ),
        );
      },
    );
  }