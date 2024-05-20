import 'package:power_of_task/Features/Auth/presentation/manger/loginCubit.dart';
import 'package:power_of_task/Features/Auth/presentation/views/widgets/authButton.dart';
import 'package:power_of_task/Features/Auth/presentation/views/widgets/authTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/functions/appToast.dart';
import '../../../../../core/utils/functions/validatore.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController? email = TextEditingController();
  TextEditingController? name = TextEditingController();
  TextEditingController? password = TextEditingController();
  TextEditingController? repeatPassword = TextEditingController();
  GlobalKey<FormState>? formstate = GlobalKey<FormState>();
  @override
  void initState() {
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
    repeatPassword = TextEditingController();
    repeatPassword = TextEditingController();
    formstate = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              height: 30.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsData.toDo2),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Welcom back!",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.sp,
            ),
            Text(
              "Login to your existing account of TaskPulse",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    AuthTextField(
                      controller: name,
                      label: 'enter your name',
                      preIcon: Icons.person,
                      vaildator: (val) {
                        return vaildator(val!, 2, 20, 'name');
                      },
                      obscureText: false,
                      suffixIcon: null,
                      suffixIconOnPressed: () {},
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                      return AuthTextField(
                        controller: password,
                        label: 'enter your password',
                        preIcon: Icons.password,
                        vaildator: (val) {
                          return vaildator(val!, 5, 15, 'password');
                        },
                        obscureText: loginCubit.isPassword,
                        suffixIcon: loginCubit.isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixIconOnPressed: () {
                          loginCubit.revPassword();
                        },
                      );
                    }),
                    SizedBox(
                      height: 7.h,
                    ),
                    AuthButton(
                      widget: BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            appToast(context, 'Registration successful!');
                          } else if (state is LoginFailure) {
                            appToast(context, state.errMessage);
                          }
                        },
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return SizedBox(
                                height: 3.h,
                                width: 6.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                "Create",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      radius: 13.sp,
                      paddinghorizontal: 7.h,
                      paddingvertical: 2.h,
                      onpressed: () {
                        loginCubit.makeLogin({
                          "password": password!.text,
                          "username": name!.text
                        }, formstate, context);
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                            onPressed: () {
                              //  Get.offNamed(AuthRoute.Login);
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: kPrimaryColor),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
