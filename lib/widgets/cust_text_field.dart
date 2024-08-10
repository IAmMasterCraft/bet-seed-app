import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustTextField extends StatelessWidget {
  const CustTextField({
    Key? key,
    this.controller,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.mHintText,
    this.onChanged,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.height,
    this.width,
    this.enabled,
    this.suffixIcon,
    this.obscureText,
    this.counter,
    // this.counterText,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.prefixText,
    this.readOnly,
    this.style,
    this.suffixText,
    this.textAlign,
    this.textInputAction,
    this.validator,
    this.hintTrns = false,
    this.args,
    this.padding,
  });

  final String? initialValue;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final String? hintText;
  final String? labelText;
  final List<String>? mHintText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;

  final bool? enabled;
  final bool? readOnly;
  final int? maxLines;
  final String? prefixText;
  final String? suffixText;
  final String? Function(String?)? validator;
  final bool? obscureText;

  final TextStyle? style;
  final TextAlign? textAlign;

  final double? height;
  final double? width;

  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Widget? counter;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool hintTrns;
  final Map<String, String>? args;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      child: TextFormField(
        obscureText: obscureText ?? false,
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        enabled: enabled ?? true,
        focusNode: focusNode,
        textAlign: textAlign ?? TextAlign.left,
        validator: validator,
        maxLines: maxLines ?? 1,
        readOnly: readOnly ?? false,
        style: style,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffix: suffix,
          suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
