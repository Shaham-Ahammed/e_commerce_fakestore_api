import 'package:e_commerce_fake_store_api/core/utils/appbar.dart';
import 'package:e_commerce_fake_store_api/core/utils/font.dart';
import 'package:e_commerce_fake_store_api/core/utils/loading.dart';
import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:e_commerce_fake_store_api/view/screens/accounts.dart';
import 'package:e_commerce_fake_store_api/viewmodels/users_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: customAppBar("Login", false, context),
      body: Center(
        child: Consumer<UsersViewmodel>(
          builder: (context, userViewModel, child) {
            return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColors.secondaryColor)),
              onPressed: () async {
                showLoadingDialog(context);

                await userViewModel.fetchUsers();

                if (context.mounted) {
                  Navigator.pop(context);
                  if (Provider.of<UsersViewmodel>(context, listen: false).fetchedUsers) {}
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AccountsScreen(),
                  ));
                }
              },
              child: const AppFont("Fetch Users"),
            );
          },
        ),
      ),
    );
  }
}
