import 'package:e_commerce_fake_store_api/core/utils/appbar.dart';
import 'package:e_commerce_fake_store_api/core/utils/font.dart';
import 'package:e_commerce_fake_store_api/core/utils/themes/colors.dart';
import 'package:e_commerce_fake_store_api/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartViewmodel>().listTheCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("My Cart", true, context),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<CartViewmodel>(builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (value.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                  ),
                  AppFont("Empty cart"),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                final item = value.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: AppColors.secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.image),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(width: 170, child: AppFont(item.title)),
                          const Spacer(),
                          IconButton(
                              color: AppColors.whiteColor,
                              highlightColor: AppColors.primaryColor,
                              onPressed: () {
                                context
                                    .read<CartViewmodel>()
                                    .removeItemFromCart(item.id);
                              },
                              icon: const Icon(
                                Icons.minimize,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: value.cartItems.length,
            );
          }
        }),
      ),
    );
  }
}
