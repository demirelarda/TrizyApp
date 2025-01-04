import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/sign_in/signin_bloc.dart';
import '../../bloc/auth/sign_in/signin_event.dart';
import '../../bloc/auth/sign_in/signin_state.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/textfields/custom_text_field.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (context) => SignInBloc(),
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: keyboardPadding + 50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: AppTextStyles.headlineLargest.copyWith(
                              color: primaryLightColor,
                              height: 0.99,
                            ),
                          ),
                          Text(
                            "back!",
                            style: AppTextStyles.headlineLargest.copyWith(
                              color: primaryDarkColor,
                              height: 0.99,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "Sign in to your account to take advantage of Trizy’s exclusive offers!",
                            style: AppTextStyles.bodyText.copyWith(color: gray),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      CustomTextField(
                        hintText: "Email",
                        height: screenHeight * 0.06,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        borderRadius: 12,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      CustomTextField(
                        hintText: "Password",
                        height: screenHeight * 0.06,
                        isPasswordField: true,
                        controller: passwordController,
                        borderRadius: 12,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      BlocConsumer<SignInBloc, SignInState>(
                        listener: (context, state) {
                          if (state.isSuccess) {
                            context.goNamed('mainPage');
                          } else if (state.isFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Failed!"),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            text: "Login",
                            textColor: white,
                            isLoading: state.isLoggingIn,
                            color: primaryLightColor,
                            onClick: () {
                              context.read<SignInBloc>().add(
                                SignInSubmitted(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed('signup');
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                                style:
                                AppTextStyles.bodyText.copyWith(color: gray),
                              ),
                              TextSpan(
                                text: "Register Now",
                                style: AppTextStyles.bodyText
                                    .copyWith(color: primaryLightColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        context.goNamed("mainPage");
                      },
                      child: Text(
                        "Continue as a guest",
                        style: AppTextStyles.bodyText
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}