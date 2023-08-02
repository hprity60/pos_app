import 'package:assignment_app/core/values/app_colors.dart';
import 'package:assignment_app/core/values/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/form_validator.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custome_button.dart';

class SignInScreen extends StatelessWidget {
  static const String id = "sign_in_page";
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 70),
                Text(
                  "Login",
                  style: textStyleF20W400(),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: userNameController,
                  hintText: 'Username',
                  borderRadius: 9,
                  validator: (value) {
                    return FormValidator.validateText(value: value ?? "");
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  obscureText: true,
                  controller: passwordController,
                  hintText: 'password',
                  borderRadius: 9,
                  validator: (value) {
                    return FormValidator.validateText(value: value ?? "");
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  onTap: () {},
                  isSelected: true,
                  btnColor: secondaryTextColor,
                  textColor: whiteColor,
                  text: 'SignIn',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
