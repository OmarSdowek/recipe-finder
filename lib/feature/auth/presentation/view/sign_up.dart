import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';
import 'package:food_app/core/route/routes.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/constant/assets_manger.dart';
import '../../../../core/utils/vaidation.dart';
import '../../../../core/widgets/custom_text_form_feild.dart';
import '../manger/auth_cubit/auth_cubit.dart';
import '../widgets/continue_widgets.dart';
import '../widgets/google-apple_button.dart';
import '../widgets/login_text_section.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  late TextEditingController email;
  late TextEditingController name;
  late TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w(24)),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  context.verticalSpace(40),

                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AssetsManger.logo,
                          height: context.h(80),
                          colorFilter: const ColorFilter.mode(
                            AppColors.gradientStart,
                            BlendMode.srcIn,
                          ),
                        ),
                        context.verticalSpace(20),
                        Text(
                          "Create Account",
                          style: AppTextStyles.headingMediumBlack,
                        ),
                        context.verticalSpace(8),
                        Text(
                          "Join our community of food lovers",
                          style: AppTextStyles.bodyMediumSecondary,
                        ),
                      ],
                    ),
                  ),

                  context.verticalSpace(32),

                  Text(
                    "Full Name",
                    style: AppTextStyles.semibold14White.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  context.verticalSpace(8),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.person_outline),
                    validator: (value) => AppValidators.nameValidator(
                      value,
                    ), // تأكد من وجودها في AppValidators
                    hintText: "John Doe",
                    controller: name,
                  ),

                  context.verticalSpace(16),

                  // حقل البريد الإلكتروني
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
                    hintText: "john@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                  ),

                  context.verticalSpace(16),

                  // حقل كلمة المرور
                  Text(
                    "Password",
                    style: AppTextStyles.semibold14White.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  context.verticalSpace(8),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: const Icon(
                      Icons.visibility_off_outlined,
                    ), // ميزة إضافية
                    validator: (value) =>
                        AppValidators.passwordValidator(value),
                    hintText: "**********",
                    obscureText: true,
                    controller: password,
                  ),

                  context.verticalSpace(32),

                  // زر إنشاء الحساب

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
                                context.read<AuthCubit>().signUp(
                                  email.text.trim(),
                                  password.text.trim(),
                                  name.text.trim(),
                                );
                              }
                            },
                            child: Text(
                              "Sign Up",
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
                          Navigator.pushNamed(context, Routes.signIn);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Register Success"),
                              backgroundColor: AppColors.successColor,
                            )
                          );

                        }

                      },
                  ),

                  context.verticalSpace(24),
                  CustomContinueWidgets(),
                  context.verticalSpace(10),
                  GooglrAppleButton(context),

                  context.verticalSpace(32),

                  // رابط الانتقال لتسجيل الدخول
                  Center(
                    child: LoginText(
                      "Already have an account? ",
                      "Sign In",
                      onTap: () {
                        Navigator.pushNamed(context, Routes.signIn);
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
