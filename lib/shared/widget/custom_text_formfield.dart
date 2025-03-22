import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_pilot/const/colors/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.isReadOnly = false,
    this.isErrorText = false,
    this.validator,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.onChanged,
    required this.name,
    this.textInputAction,
    this.controller,
    this.initialValue,
    this.minLine,
    this.maxLine,
    this.errorMaxLine,
    this.fontSize = 16,
    this.hintTexFontSize = 16,
    this.letterSpacing = 0.3,
    this.scrollPhysics,
    this.isTextCapitalization = false,
    this.isObscureText = false,
    this.onFocusGained,
    this.borderRadius,
    this.contentPadding = 12,
    this.valueTransformer,
    this.inputFormatters,
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isReadOnly;
  final bool? isErrorText;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  final String name;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? initialValue;
  final int? minLine;
  final int? maxLine;
  final int? errorMaxLine;
  final double fontSize;
  final double? hintTexFontSize;
  final double? letterSpacing;
  final ScrollPhysics? scrollPhysics;
  final bool isTextCapitalization;
  final VoidCallback? onFocusGained;
  final double? borderRadius;
  final double? contentPadding;
  final Function(String?)? valueTransformer;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        border: Border.all(color: AppColors.grey400),
      ),
      child: FormBuilderTextField(
        inputFormatters: inputFormatters,
        scrollPhysics: scrollPhysics,
        controller: controller,
        name: name,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: isReadOnly,
        valueTransformer: valueTransformer,
        enableSuggestions: true,
        enableInteractiveSelection: true,
        // textCapitalization:
        //     isTextCapitalization ? TextCapitalization.words : TextCapitalization.sentences,
        minLines: minLine,
        maxLines: maxLine,
        focusNode: focusNode,
        keyboardType: keyboardType,
        validator: validator,
        textInputAction: textInputAction,
        obscureText: isObscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(contentPadding ?? 16),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: (labelText ?? hintText),
          labelStyle: GoogleFonts.poppins(
            color: AppColors.grey700,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: GoogleFonts.poppins(
            fontSize: hintTexFontSize ?? fontSize,
            color: AppColors.green900,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          errorStyle: isErrorText! ? const TextStyle(color: AppColors.kErrorColor) : null,
          errorMaxLines: errorMaxLine,
        ),
      ),
    );
  }
}
