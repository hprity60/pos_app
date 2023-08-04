// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment_app/features/employee/presentation/pages/employee_list_screen.dart';
import 'package:assignment_app/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'package:assignment_app/core/values/text_styles.dart';

import '../../../../core/values/app_colors.dart';
import '../../../sign_in/presentation/widgets/custome_button.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';
  const HomeScreen({
    Key? key,
    required this.userName,
    required this.email,
    required this.phone,
    required this.designation,
    required this.joinDate,
  }) : super(key: key);

  final String userName;
  final String email;
  final String phone;
  final String designation;
  final String joinDate;
  @override
  Widget build(BuildContext context) {
    final formattedDate = joinDate.split('T00:00:00')[0];

    return Scaffold(
      backgroundColor: borderColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, SignInScreen.id);
            },
          )
        ],
        title: Text(
          'DashBoard',
          style: textStyleF19W700(),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Text(
                'User Info',
                style: textStyleF22W700(),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username: $userName',
                      style: textStyleF18W400(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Email: $email',
                      style: textStyleF18W400(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Phone: $phone',
                      style: textStyleF18W400(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Designation: $designation',
                      style: textStyleF18W400(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Joining Date: $formattedDate',
                      style: textStyleF18W400(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, EmployeeListScreen.id);
                },
                isSelected: true,
                btnColor: secondaryTextColor,
                textColor: whiteColor,
                text: 'Employee list',
              ),
            )
          ],
        ),
      )),
    );
  }
}
