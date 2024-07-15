import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:myproject/core/ui.dart';
import 'package:myproject/data/models/user/product/product_model.dart';
import 'package:myproject/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:myproject/logic/cubits/cart_cubit/cart_state.dart';
import 'package:myproject/logic/cubits/services/formatter.dart';
import 'package:myproject/presentation/widgets/gap_widget.dart';
import 'package:myproject/presentation/widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  static const routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images?.length ?? 0,
                slideBuilder: (index) {
                  String url = widget.productModel.images![index];

                  return CachedNetworkImage(
                    imageUrl: url,
                  );
                },
              ),
            ),
            const GapWidget(),
            Text(
              "${widget.productModel.title}",
              style: TextStyles.heading3,
            ),
            Text(
              Formatter.formatPrice(widget.productModel.price!),
              style: TextStyles.heading2,
            ),
            const GapWidget(size: 10),
            BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              bool isInCart = BlocProvider.of<CartCubit>(context)
                  .cartContains(widget.productModel);
              return PrimaryButton(
                  onPressed: () {
                    if (isInCart) {
                      return;
                    }
                    BlocProvider.of<CartCubit>(context)
                        .addToCart(widget.productModel, 1);
                  },
                  color: (isInCart) ? AppColors.textLight : AppColors.accent,
                  text: (isInCart) ? "Product added to cart" : "Add to Cart");
            }),
            const GapWidget(size: 10),
            Text(
              "Description",
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.productModel.description}",
              style: TextStyles.body1,
            ),
          ],
        ),
      ),
    );
  }
}
