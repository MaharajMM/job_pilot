import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/const/borders/app_borders.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.borderRadius,
    required this.labelText,
    required this.onPressed,
    this.isLoading = false,
    this.color = AppColors.kPrimaryColor,
    this.freeSize = false,
    this.fontSize,
    this.icon = const Icon(Icons.download_rounded),
    this.isIcon = false,
    this.borderColor,
    this.fontColor = AppColors.kBlack,
    this.padding,
  });
  final BorderRadiusGeometry? borderRadius;
  final String labelText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final bool freeSize;
  final Widget? icon;
  final bool isIcon;
  final double? fontSize;
  final Color? borderColor;
  final Color? fontColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return isIcon
        ? ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? AppBorder.kHalfMiddleCurve,
                side: BorderSide(color: borderColor ?? Colors.transparent),
              ),
              padding: padding,
              backgroundColor: color,
              minimumSize: freeSize ? const Size(0, 0) : Size(double.infinity, 50),
            ),
            icon: icon!,
            label: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: fontColor ?? AppColors.kBlack,
                  ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? AppBorder.kHalfMiddleCurve,
              ),
              backgroundColor: color,
              padding: padding,
              minimumSize: freeSize ? const Size(0, 0) : Size(double.infinity, 50),
            ),
            child: <Widget>[
              if (isLoading) const CupertinoActivityIndicator(),
              Text(
                labelText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: fontColor ?? AppColors.kBlack,
                    ),
              ).pOnly(left: 5),
            ].hStack(alignment: MainAxisAlignment.center),
          );
  }
}
