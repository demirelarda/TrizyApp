import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/sign_up/signup_bloc.dart';
import '../../bloc/auth/sign_up/signup_event.dart';
import '../../bloc/auth/sign_up/signup_state.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/textfields/custom_text_field.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (context) => SignupBloc(),
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
                            "Hello",
                            style: AppTextStyles.headlineLargest.copyWith(
                              color: primaryLightColor,
                              height: 0.99,
                            ),
                          ),
                          Text(
                            "there!",
                            style: AppTextStyles.headlineLargest.copyWith(
                              color: primaryDarkColor,
                              height: 0.99,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "Create your account to take advantage of Trizy’s exclusive offers!",
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
                        hintText: "First Name",
                        height: screenHeight * 0.06,
                        controller: firstNameController,
                        keyboardType: TextInputType.name,
                        borderRadius: 12,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      CustomTextField(
                        hintText: "Last Name",
                        height: screenHeight * 0.06,
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        borderRadius: 12,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      CustomTextField(
                        hintText: "Password",
                        height: screenHeight * 0.06,
                        controller: passwordController,
                        isPasswordField: true,
                        borderRadius: 12,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          "By signing up you agree to Trizy's Terms and Conditions.",
                          style: AppTextStyles.bodyText.copyWith(color: gray),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      BlocConsumer<SignupBloc, SignupState>(
                        listener: (context, state) {
                          if (state.isSuccess) {
                            context.goNamed('mainPage');
                          } else if (state.isFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Signup Failed!")),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            text: "Sign Up",
                            textColor: white,
                            isLoading: state.isSubmitting,
                            color: primaryLightColor,
                            onClick: () {
                              context.read<SignupBloc>().add(
                                SignupSubmitted(
                                  email: emailController.text,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
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
                          context.goNamed('login');
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account? ",
                                style: AppTextStyles.bodyText.copyWith(color: gray),
                              ),
                              TextSpan(
                                text: "Login",
                                style: AppTextStyles.bodyText.copyWith(color: primaryLightColor),
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