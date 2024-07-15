import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:myproject/core/ui.dart';
import 'package:myproject/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:myproject/logic/cubits/cart_cubit/cart_state.dart';
import 'package:myproject/logic/cubits/services/calculation.dart';
import 'package:myproject/logic/cubits/services/formatter.dart';
import 'package:myproject/presentation/widgets/link_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if (state is CartLoadingState && state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartErrorState && state.items.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CartLoadedState && state.items.isEmpty) {
            return const Center(child: Text("Cart items will show up here.."));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                          imageUrl: item.product!.images![0]),
                      title: Text("${item.product?.title}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${Formatter.formatPrice(item.product!.price!)} x ${item.quantity} = ${Formatter.formatPrice(item.product!.price! * item.quantity!)}"),
                          LinkButton(
                            onPressed: () {
                              BlocProvider.of<CartCubit>(context)
                                  .removeFromCart(item.product!);
                            },
                            text: "Delete",
                            color: Colors.red,
                          )
                        ],
                      ),
                      trailing: InputQty(
                        minVal: 1,
                        initVal: item.quantity!,
                        maxVal: 99,
                        showMessageLimit: false,
                        onQtyChanged: (value) {
                          BlocProvider.of<CartCubit>(context)
                              .addToCart(item.product!, value as int);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${state.items.length}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              )),
                          Text(
                            "Total:${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                            style: TextStyles.heading3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: CupertinoButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 22),
                        color: AppColors.accent,
                        child: Text("place your order"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
