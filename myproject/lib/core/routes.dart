import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/data/models/user/category/category_model.dart';
import 'package:myproject/data/models/user/product/product_model.dart';
import 'package:myproject/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:myproject/logic/cubits/category_product_cubit/category_product_state.dart';
import 'package:myproject/presentation/screens/auth/Providers/login_provider.dart';
import 'package:myproject/presentation/screens/auth/Providers/signup_provider.dart';
import 'package:myproject/presentation/screens/auth/login_screen.dart';
import 'package:myproject/presentation/screens/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:myproject/presentation/screens/cart/cart_screen.dart';
import 'package:myproject/presentation/screens/home/home_screen.dart';
import 'package:myproject/presentation/screens/product/category_product_screen.dart';
import 'package:myproject/presentation/screens/product/product_detail_screen.dart';
import 'package:myproject/presentation/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen()));

      case SignupScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignupProvider(context),
                child: const SignupScreen()));

      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());

      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailsScreen(
                  productModel: settings.arguments as ProductModel,
                ));

      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const CartScreen());

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    CategoryProductCubit(settings.arguments as CategoryModel),
                child: const CategoryProductScreen()));
      default:
        return null;
    }
  }
}
