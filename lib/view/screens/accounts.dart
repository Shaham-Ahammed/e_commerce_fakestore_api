import 'package:e_commerce_fake_store_api/core/utils/appbar.dart';
import 'package:e_commerce_fake_store_api/core/utils/font.dart';
import 'package:e_commerce_fake_store_api/core/utils/loading.dart';
import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:e_commerce_fake_store_api/view/screens/categories.dart';
import 'package:e_commerce_fake_store_api/viewmodels/users_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: customAppBar("Accounts", true, context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(
              Provider.of<UsersViewmodel>(context, listen: false)
                  .userData!
                  .users
                  .length,
              (index) {
                final item = Provider.of<UsersViewmodel>(context, listen: false)
                    .userData!
                    .users[index];
                return Material(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    splashColor: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      showLoadingDialog(context);
                      await context.read<UsersViewmodel>().loginUser(item);
                      if (context.mounted) {
                        Navigator.pop(context);
                        if (Provider.of<UsersViewmodel>(context, listen: false)
                            .userLoggedIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.secondaryColor,
                              content: const Center(child: Text('login success')),
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const CategoriesScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppFont(item.userName),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
