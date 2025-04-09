import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/app_button.dart';
import 'package:drive_app/src/core/utils/loading_page.dart';
import 'package:drive_app/src/feature/login/model/login_form_model.dart';
import 'package:drive_app/src/feature/login/view/widgte/collection/auth_form_widget.dart';
import 'package:drive_app/src/feature/login/view/widgte/text/login_text.dart';
import 'package:drive_app/src/feature/register/controller/register_controller.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool showPassword = true.obs;

    final controller = Get.put(RegisterController());
    RxString errorText = "valid".obs;
    RxInt index = 0.obs;

    String? validateOneFields() {
      RxList<String?> errors = <String>[].obs;

      // Validate each form field and collect errors
      final genderError = controller.vaildGender();
      final majorError = controller.vaildMajor();
      final stdID = controller.validName(controller.studentID.text);

      if (genderError != null) errors.add("- $genderError");
      if (majorError != null) errors.add("- $majorError");
      if (stdID != null) errors.add("- $stdID");

      if (errors.isNotEmpty) {
        return errors.first;
      }
      return "valid";
    }

    PageController pageController = PageController();

    String? validateTwoFields() {
      RxList<String?> errors = <String>[].obs;

      // Validate each form field and collect errors
      final emailError = controller.vaildEmail(controller.email.text);
      final passwordError = controller.vaildPassword(controller.password.text);
      final firstName = controller.validName(controller.name.text);

      if (emailError != null) errors.add("- $emailError");
      if (passwordError != null) errors.add("- $passwordError");
      if (firstName != null) errors.add("- $firstName");

      if (errors.isNotEmpty) {
        return errors.first;
      }
      return "valid";
    }

    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: Obx(
        () => Stack(
          children: [
            Container(
                width: context.screenWidth,
                decoration: BoxDecoration(
                    color: AppTheme.lightAppColors.background,
                    borderRadius: BorderRadius.circular(20)),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        LoginText.mainText('Sign Up'),
                        10.0.kH,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              10.0.kH,
                              ExpandablePageView(
                                controller: pageController,
                                children: [
                                  pageOne(controller, errorText, showPassword),
                                  pageTwo(controller, errorText, showPassword)
                                ],
                                onPageChanged: (value) {
                                  print(value);
                                  index.value = value;
                                },
                              ),
                              appButton(
                                  title: "Register",
                                  onTap: () {
                                    if (index.value == 0) {
                                      errorText.value = validateOneFields()!;
                                      errorText.value == 'valid'
                                          ? {
                                              pageController.nextPage(
                                                  duration:
                                                      Duration(milliseconds: 300),
                                                  curve: Curves.linear),
                                            }
                                          : null;
                                    } else {
                                      errorText.value = validateTwoFields()!;
                                      errorText.value == 'valid'
                                          ? controller.register(context)
                                          : null;
                                    }
                                  },
                                  width: context.screenWidth * .4),
                              10.0.kH,
                              20.0.kH,
                              Container(
                                  height: context.screenHeight * .03,
                                  width: context.screenWidth,
                                  decoration: BoxDecoration(
                                      color: AppTheme.lightAppColors.background,
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(30))),
                                  child: Center(
                                    child: LoginText.dontHaveAccount(() {
                                      Get.back();
                                    }),
                                  )),
                              20.0.kH,
                              20.0.kH,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            controller.isLoading.value
                ? loadingPage(context)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

pageTwo(
    RegisterController controller, RxString errorText, RxBool showPassword) {
  return Column(
    children: [
      Obx(() {
        return errorText.value != "valid"
            ? Row(
                children: [
                  Text(
                    errorText.value,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    textAlign: TextAlign.start,
                  ),
                ],
              )
            : const SizedBox.shrink(); // If no errors, display nothing
      }),
      AuthForm(
        formModel: FormModel(
            icon: Icons.person_2_outlined,
            controller: controller.name,
            enableText: false,
            hintText: 'Username',
            invisible: false,
            validator: null,
            type: TextInputType.emailAddress,
            inputFormat: [],
            onTap: () {}),
      ),
      (25.5).kH,
      AuthForm(
        formModel: FormModel(
            icon: Icons.email_outlined,
            controller: controller.email,
            enableText: false,
            hintText: 'Email',
            invisible: false,
            validator: null,
            type: TextInputType.emailAddress,
            inputFormat: [],
            onTap: () {}),
      ),
      (25.5).kH,
      Stack(
        children: [
          AuthForm(
            formModel: FormModel(
                icon: Icons.lock_outline,
                controller: controller.password,
                enableText: false,
                hintText: 'Password',
                invisible: showPassword.value,
                validator: null,
                type: TextInputType.text,
                inputFormat: [],
                onTap: () {}),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    showPassword.value = !showPassword.value;
                  },
                  icon: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                    child: Icon(
                      !showPassword.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: AppTheme.lightAppColors.primary,
                    ),
                  )),
            ],
          )
        ],
      ),
      // (25.5).kH,
    ],
  );
}

pageOne(
    RegisterController controller, RxString errorText, RxBool showPassword) {
  return Column(
    children: [
      Obx(() {
        return errorText.value != "valid"
            ? Row(
                children: [
                  Text(
                    errorText.value,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    textAlign: TextAlign.start,
                  ),
                ],
              )
            : const SizedBox.shrink(); // If no errors, display nothing
      }),
      GenderDropdown(
        controller: controller.genderController,
      ),
      (25.5).kH,
      MajorDropdown(
        controller: controller.majorController,
      ),
      (25.5).kH,
      AuthForm(
        formModel: FormModel(
            icon: Icons.book_outlined,
            controller: controller.studentID,
            enableText: false,
            hintText: 'Student ID',
            invisible: false,
            validator: null,
            type: TextInputType.emailAddress,
            inputFormat: [],
            onTap: () {}),
      ),
      (25.5).kH,
    ],
  );
}

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({
    super.key,
    required this.controller,
    this.hintText = "Select Gender",
    this.icon = Icons.person_2_outlined,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  final List<String> genderOptions = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.controller.text.isNotEmpty ? widget.controller.text : null,
      items: genderOptions
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.controller.text = value ?? '';
        });
      },
      dropdownColor:
          Colors.white, // Change this to your desired background color

      decoration: InputDecoration(
        prefixIcon:
            Icon(widget.icon, color: AppTheme.lightAppColors.subTextcolor),
        filled: true,
        fillColor: AppTheme.lightAppColors.background.withOpacity(0.9),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: "kanti",
          fontWeight: FontWeight.w200,
          color: AppTheme.lightAppColors.subTextcolor,
        ),
      ),
    );
  }
}

class MajorDropdown extends StatefulWidget {
  const MajorDropdown({
    super.key,
    required this.controller,
    this.hintText = "Select Major",
    this.icon = Icons.school_outlined,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  @override
  State<MajorDropdown> createState() => _MajorDropdownState();
}

class _MajorDropdownState extends State<MajorDropdown> {
  final List<String> majorOptions = [
    'Computer Science',
    'Business Administration',
    'Mechanical Engineering',
    'Electrical Engineering',
    'Medicine',
    'Law',
    'Architecture',
    'Psychology',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.controller.text.isNotEmpty ? widget.controller.text : null,
      items: majorOptions
          .map((major) => DropdownMenuItem(
                value: major,
                child: Text(major),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.controller.text = value ?? '';
        });
      },
      dropdownColor:
          Colors.white, // Change this to your desired background color

      decoration: InputDecoration(
        prefixIcon:
            Icon(widget.icon, color: AppTheme.lightAppColors.subTextcolor),
        filled: true,
        fillColor: AppTheme.lightAppColors.background.withOpacity(0.9),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: "kanti",
          fontWeight: FontWeight.w200,
          color: AppTheme.lightAppColors.subTextcolor,
        ),
      ),
    );
  }
}
