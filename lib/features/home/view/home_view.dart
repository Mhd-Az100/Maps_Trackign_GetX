import 'package:flutter/material.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryBlue,
        title: Text(
          'Home',
          style: AppTextStyles.bold20.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
