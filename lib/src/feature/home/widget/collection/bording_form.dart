import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/login/model/login_form_model.dart';
import 'package:flutter/material.dart';

class BordingForm extends StatefulWidget {
  const BordingForm({
    required this.formModel,
    this.ontap,
    super.key,
  });

  final FormModel formModel;
  final VoidCallback? ontap;

  @override
  State<BordingForm> createState() => _BordingFormState();
}

class _BordingFormState extends State<BordingForm> {
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
        decoration: InputDecoration(
          prefixIcon: Icon(widget.formModel.icon,
              color: AppTheme.lightAppColors.subTextcolor),
          filled: true,
          fillColor: AppTheme.lightAppColors.background.withValues(alpha: 0.9),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.lightAppColors.bordercolor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.lightAppColors.bordercolor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: "  ${widget.formModel.hintText}",
          hintStyle: TextStyle(
            fontFamily: "kanti",
            fontWeight: FontWeight.w200,
            color: AppTheme.lightAppColors.subTextcolor,
          ),
        ));
  }
}
