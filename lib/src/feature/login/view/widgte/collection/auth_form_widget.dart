import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/login/model/login_form_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthForm extends StatefulWidget {
  AuthForm({
    required this.formModel,
    this.textAlign,
    this.ontap,
    super.key,
  });

  FormModel formModel;
  VoidCallback? ontap;
  TextAlign? textAlign;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: widget.ontap,
        onChanged: widget.formModel.onChange,
        textInputAction: TextInputAction.done,
        cursorColor: AppTheme.lightAppColors.black,
        style: TextStyle(
          color: AppTheme.lightAppColors.mainTextcolor,
        ),
        readOnly: widget.formModel.enableText,
        inputFormatters: widget.formModel.inputFormat,
        keyboardType: widget.formModel.type,
        validator: widget.formModel.validator,
        obscureText: widget.formModel.invisible,
        controller: widget.formModel.controller,
        textAlign: TextAlign.start, // Center align the text and hint

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          // prefixIcon: Icon(widget.formModel.icon,
          //     color: AppTheme.lightAppColors.subTextcolor),
          filled: true,

          fillColor: AppTheme.lightAppColors.background.withValues(alpha: 0.9),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.1),
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.1),
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          hintText: widget.formModel.hintText,
          hintStyle: TextStyle(
            fontFamily: "kanti",
            fontWeight: FontWeight.w200,
            color: AppTheme.lightAppColors.subTextcolor,
          ),
        ));
  }
}
