// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_fake_store_api/core/utils/appbar.dart';
import 'package:e_commerce_fake_store_api/core/utils/font.dart';
import 'package:e_commerce_fake_store_api/core/utils/loading.dart';
import 'package:e_commerce_fake_store_api/core/utils/snackbar.dart';
import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:e_commerce_fake_store_api/viewmodels/cart_viewmodel.dart';
import 'package:e_commerce_fake_store_api/viewmodels/items_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatefulWidget {
  final String category;
  const ItemsScreen({required this.category, super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog(context);
      context.read<ItemsViewmodel>().fetchItems(widget.category).then((_) {
        Navigator.pop(context);
        if (context.read<ItemsViewmodel>().errorWhileFetching) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: AppColors.primaryColor,
                content: const Center(child: Text("Error while fetching"))),
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(widget.category, true, context),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<ItemsViewmodel>(builder: (context, value, child) {
          if (value.fetchedItems) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final item = value.itemModel!.items[index];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.whiteColor, width: .5),
                        color: AppColors.secondaryColor),
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.contain,
                              item.image),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 280,
                                  child: AppFont(
                                    item.title,
                                    overflow: TextOverflow.ellipsis,
                                    size: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                AppFont(
                                  "\$ ${item.price.toString()} /-",
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor,
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () async {
                                  await context
                                      .read<CartViewmodel>()
                                      .addItemToCart(item.id);
                                  if (Provider.of<CartViewmodel>(context,
                                          listen: false)
                                      .itemAdded) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackbar(
                                          "${item.title} added to cart"),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackbar(
                                          "${item.title} already exists in cart"),
                                    );
                                  }
                                },
                                icon: Icon(
                                  size: 30,
                                  Icons.shopping_cart_checkout_outlined,
                                  color: AppColors.whiteColor,
                                ))
                          ],
                        ),
                        Divider(
                          height: 4,
                          color: AppColors.whiteColor,
                        ),
                        AppFont(
                          item.description,
                          size: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(padding: EdgeInsets.all(8));
                },
                itemCount: value.itemModel!.items.length);
          }

          return const SizedBox();
        }),
      ),
    );
  }
}
