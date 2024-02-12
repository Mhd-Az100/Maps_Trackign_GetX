import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/core/utils/validator.dart';
import 'package:watt_test/core/widgets/button_widget.dart';
import 'package:watt_test/core/widgets/textfield_widget.dart';
import 'package:watt_test/features/auth/controller/auth_controller.dart';
import 'package:watt_test/features/auth/widget/user_credential_widget.dart';

class LoginView extends GetView<AuthController> {
  LoginView({super.key});
  final formKey = GlobalKey<FormBuilderState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  // dependency injection for auth controller
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: AppTextStyles.bold24.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryBlue,
      ),
      body: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Name",
              style: AppTextStyles.bold14.copyWith(color: AppColors.darkgrey),
            ).paddingAll(8),
            TextFieldWidget(
              controller: usernameController,
              name: "username",
              keyboardType: TextInputType.name,
              validator: Validator.validateText,
              fillColor: AppColors.white2,
              hint: "Enter User Name",
            ),
            SizedBox(height: 20.h),
            Text(
              "Password",
              style: AppTextStyles.bold14.copyWith(color: AppColors.darkgrey),
            ).paddingAll(8),
            //
            GetX<AuthController>(builder: (controller) {
              return TextFieldWidget(
                controller: passwordController,
                name: "password",
                hint: "************",
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                validator: Validator.validateText,
                fillColor: AppColors.white2,
                isPassword: true,
                visible: controller.visible.value,
                suffixIcon: IconButton(
                    onPressed: () =>
                        controller.visible.value = !controller.visible.value,
                    icon: Icon(
                        controller.visible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.primaryBlue)),
              );
            }),
            //
            SizedBox(height: 20.h),
            ButtonWidget(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  authController.login(
                      usernameController.text, passwordController.text);
                }
              },
              child: Obx(() => authController.loading.value
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Login",
                      style: AppTextStyles.bold18.copyWith(color: Colors.white),
                    )),
            ),
            const Spacer(),
            UserCredentialInfo(
                usernameController: usernameController,
                passwordController: passwordController),
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
      ),
    );
  }
}
