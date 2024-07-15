import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/core/ui.dart';
import 'package:myproject/logic/cubits/product_cubit/product_cubit.dart';
import 'package:myproject/logic/cubits/product_cubit/product_state.dart';
import 'package:myproject/logic/cubits/services/formatter.dart';
import 'package:myproject/presentation/screens/product/product_detail_screen.dart';
import 'package:myproject/presentation/widgets/gap_widget.dart';
import 'package:myproject/presentation/widgets/product_list_view.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadingState && state.products.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is ProductErrorState && state.products.isEmpty) {
        return Center(
          child: Text(state.message),
        );
      }

      return ProductListView(products: state.products);
    });
  }
}
