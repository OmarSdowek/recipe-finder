import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/constant/assets_manger.dart';
import '../../../../core/route/routes.dart';
import '../../../../core/utils/vaidation.dart';
import '../../../../core/widgets/custom_text_form_feild.dart';
import '../manger/auth_cubit/auth_cubit.dart';
import '../widgets/build_app_bar.dart';
import '../widgets/continue_widgets.dart';
import '../widgets/google-apple_button.dart';
import '../widgets/login_text_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w(24)),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  context.verticalSpace(10),

                  Center(
                    child: Image.asset(
                      AssetsManger.signUp,
                      width: context.screenWidth,
                      height: context.h(200),
                    ),
                  ),

                  context.verticalSpace(10),

                  Text("Welcome Back", style: AppTextStyles.bold32black),
                  context.verticalSpace(8),
                  Text(
                    "Sign in to continue your culinary journey",
                    style: AppTextStyles.semibold16Black,
                  ),

                  context.verticalSpace(20),

                  // Email
                  Text(
                    "Email",
                    style: AppTextStyles.semibold14White.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  context.verticalSpace(8),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: AppValidators.emailValidator,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                  ),

                  context.verticalSpace(15),

                  // Password
                  Text(
                    "Password",
                    style: AppTextStyles.semibold14White.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  context.verticalSpace(8),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: const Icon(Icons.visibility_off_outlined),
                    validator: AppValidators.passwordValidator,
                    hintText: "Enter your password",
                    obscureText: true,
                    controller: password,
                  ),

                  context.verticalSpace(8),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot Password Logic
                      },
                      child: Text(
                        "Forgot Password?",
                        style: AppTextStyles.bodyBoldSecondary.copyWith(
                          color: AppColors.gradientEnd,
                        ),
                      ),
                    ),
                  ),

                  context.verticalSpace(10),
                  BlocConsumer<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return state is AuthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: context.h(16)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(context.r(12)),
                            ),
                            backgroundColor: AppColors.gradientStart,
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().signIn(
                                email.text.trim(),
                                password.text.trim(),
                              );
                            }
                          },
                          child: Text(
                            "Sign In",
                            style: AppTextStyles.titleMediumWhiteBold,
                          ),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: AppColors.errorColor,
                          ),
                        );
                        print(state.message);
                      }
                      if (state is AuthSuccess) {
                        Navigator.pushNamed(context, Routes.home);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("LogIn Success"),
                              backgroundColor: AppColors.successColor,
                            )
                        );

                      }

                    },
                  ),

                  // Sign In Button


                  context.verticalSpace(10),

                  // Or continue with
                  CustomContinueWidgets(),

                  context.verticalSpace(10),
                  GooglrAppleButton(context),

                  context.verticalSpace(32),

                  // Sign Up link
                  Center(
                    child: LoginText(
                      "Don't have an account? ",
                      "Sign Up",
                      onTap: () {
                        Navigator.pushNamed(context, Routes.signUp);
                      },
                    ),
                  ),
                  context.verticalSpace(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
