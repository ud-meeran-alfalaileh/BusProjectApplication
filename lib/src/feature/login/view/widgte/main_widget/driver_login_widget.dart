import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/app_button.dart';
import 'package:drive_app/src/core/utils/loading_page.dart';
import 'package:drive_app/src/feature/login/controller/driver_login_controller.dart';
import 'package:drive_app/src/feature/login/model/login_form_model.dart';
import 'package:drive_app/src/feature/login/view/widgte/collection/auth_form_widget.dart';
import 'package:drive_app/src/feature/login/view/widgte/text/login_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverLoginWidget extends StatefulWidget {
  const DriverLoginWidget({super.key});

  @override
  State<DriverLoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<DriverLoginWidget> {
  final controller = Get.put(DriverLoginController());

  RxString errorText = "valid".obs;
  String? validateAllFields() {
    RxList<String?> errors = <String>[].obs;

    // Validate each form field and collect errors
    final dtudentIdError = controller.validName(controller.email.text);
    final passwordError = controller.vaildPassword(controller.password.text);

    if (dtudentIdError != null) errors.add("- $dtudentIdError");
    if (passwordError != null) errors.add("- $passwordError");

    if (errors.isNotEmpty) {
      return errors.first;
    }
    return "valid";
  }

  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RxBool showPassword = true.obs;
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Form(
                    key: fromKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: context.screenWidth,
                                height: context.screenHeight * .3,
                                color: AppTheme.lightAppColors.primary,
                                child: Image.asset(
                                  'assets/image/logo (2).png',
                                  width: context.screenWidth * .3,
                                ),
                              ),
                              10.0.kH,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  children: [
                                    30.0.kH,

                                    LoginText.mainText('Sign In as Driver'.tr),
                                    30.0.kH,
                                    Obx(() {
                                      return errorText.value != "valid"
                                          ? Row(
                                              children: [
                                                Text(
                                                  errorText.value,
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          : const SizedBox
                                              .shrink(); // If no errors, display nothing
                                    }),
                                    AuthForm(
                                      formModel: FormModel(
                                          icon: Icons.person_2_outlined,
                                          controller: controller.email,
                                          enableText: false,
                                          hintText: 'Email'.tr,
                                          invisible: false,
                                          validator: null,
                                          type: TextInputType.number,
                                          inputFormat: [],
                                          onTap: () {}),
                                    ),
                                    (30.5).kH,
                                    //password
                                    Stack(
                                      children: [
                                        AuthForm(
                                          formModel: FormModel(
                                              icon: Icons.lock_outline,
                                              controller: controller.password,
                                              enableText: false,
                                              hintText: 'loginPassword'.tr,
                                              invisible: showPassword.value,
                                              validator: null,
                                              type: TextInputType.text,
                                              inputFormat: [],
                                              onTap: () {}),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showPassword.value =
                                                      !showPassword.value;
                                                },
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, right: 20),
                                                  child: Icon(
                                                    !showPassword.value
                                                        ? Icons
                                                            .remove_red_eye_outlined
                                                        : Icons.remove_red_eye,
                                                    color: AppTheme
                                                        .lightAppColors.primary,
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                    50.0.kH,
                                    appButton(
                                        title: "Login".tr,
                                        onTap: () {
                                          errorText.value =
                                              validateAllFields()!;
                                          errorText.value == 'valid'
                                              ? controller.login(context)
                                              : null;
                                        },
                                        width: context.screenWidth * .4),
                                    10.0.kH,
                                  ],
                                ),
                              )
                            ],
                          ),
                          // Container(
                          //     height: context.screenHeight * .03,
                          //     width: context.screenWidth,
                          //     decoration: BoxDecoration(
                          //         color: AppTheme.lightAppColors.background,
                          //         borderRadius: const BorderRadius.vertical(
                          //             top: Radius.circular(30))),
                          //     child: Center(
                          //       child: LoginText.haveAccount(() {
                          //         Get.to(() => const RegisterPage());
                          //       }),
                          //     )),
                        ],
                      ),
                    ),
                  ),
                  controller.isLoading.value
                      ? loadingPage(context)
                      : const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 60),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppTheme.lightAppColors.background,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector loginTypeLogin(
      BuildContext context, title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        width: context.screenWidth * .2,
        decoration: BoxDecoration(
            color: AppTheme.lightAppColors.bordercolor,
            borderRadius: BorderRadius.circular(9)),
        child: Center(child: LoginText.secText(title)),
      ),
    );
  }
}
