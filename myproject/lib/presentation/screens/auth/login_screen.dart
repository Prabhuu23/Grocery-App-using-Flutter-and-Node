import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/logic/cubits/user_cubit/user_cubit.dart';
import 'package:myproject/logic/cubits/user_cubit/user_state.dart';
import 'package:myproject/presentation/screens/auth/Providers/login_provider.dart';
import 'package:myproject/presentation/screens/auth/signup_screen.dart';
import 'package:myproject/presentation/screens/home/home_screen.dart';
import 'package:myproject/presentation/screens/splash/splash_screen.dart';
import 'package:myproject/presentation/widgets/gap_widget.dart';
import 'package:myproject/presentation/widgets/link_button.dart';
import 'package:myproject/presentation/widgets/primary_textfield.dart';
import 'package:myproject/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("Grocery App"),
        ),
        body: SafeArea(
          child: Form(
            key: provider.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                const GapWidget(size: -5),
                (provider.error != "")
                    ? Text(
                        provider.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                GapWidget(),
                PrimaryTextField(
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address is required!";
                    }

                    if (!EmailValidator.validate(value.trim())) {
                      return "Invalid email address";
                    }

                    return null;
                  },
                  labelText: "Email Address",
                ),
                const GapWidget(),
                PrimaryTextField(
                  controller: provider.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required!";
                    }
                    return null;
                  },
                  labelText: "Password",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LinkButton(
                      text: "Forgot Password",
                      onPressed: () {},
                    ),
                  ],
                ),
                const GapWidget(),
                PrimaryButton(
                  onPressed: provider.logIn,
                  text: (provider.isLoading) ? "...." : "Log In ",
                ),
                const GapWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    const GapWidget(),
                    LinkButton(
                      text: "Sign Up",
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
