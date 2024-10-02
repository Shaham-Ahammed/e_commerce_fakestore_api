import 'package:e_commerce_fake_store_api/core/utils/appbar.dart';
import 'package:e_commerce_fake_store_api/core/utils/font.dart';
import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:e_commerce_fake_store_api/view/screens/items.dart';
import 'package:e_commerce_fake_store_api/viewmodels/categories_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    context.read<CategoriesViewmodel>().getAllCategries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: customAppBar("Categories", false, context, true),
        body: Consumer<CategoriesViewmodel>(
          builder: (context, value, child) {
            if (value.categoriesLoaded) {
              final cat = value.categoriesModel!.items;
              return Center(
                child: Wrap(
                  children: List.generate(
                    value.categoriesModel!.items.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ItemsScreen(category: cat[index]),
                          )),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.secondaryColor),
                            child: Center(
                              child: AppFont(
                                cat[index],
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }
          },
        ));
  }
}
