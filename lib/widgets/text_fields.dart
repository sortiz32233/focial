import 'package:flutter/material.dart';

class TFWithIcon extends StatelessWidget {
  final String hint;
  final String label;
  final int validateLength;
  final Function(String) onChange;
  final String Function(String) validator;
  final Function(String) save;
  final bool isObscure;
  final TextInputType textInputType;
  final int maxLength;
  final TextEditingController controller;
  final int maxLines;
  final Widget suffixIcon;
  final String initialValue;
  final EdgeInsets contentPadding;
  final Widget suffix;
  final Color borderColor;
  final IconData icon;
  final double iconSize;
  final String error;
  final TextInputAction textInputAction;

  const TFWithIcon(
      {Key key,
      this.hint,
      this.label,
      this.validateLength,
      this.onChange,
      this.validator,
      this.save,
      this.isObscure = false,
      this.textInputType,
      this.maxLength,
      this.controller,
      this.maxLines,
      this.suffixIcon,
      this.initialValue,
      this.contentPadding =
          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      this.suffix,
      this.borderColor = Colors.white,
      this.icon,
      this.iconSize,
      this.error,
      this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      scrollPhysics: const PageScrollPhysics(),
      controller: controller,
      validator: validator ??
          (value) {
            if (validateLength == 0) return null;
            if (value == null) return "Invalid input";

            if (value.length < validateLength)
              return "${label ?? "Input"} must be valid";

            return null;
          },
      textAlign: label.toLowerCase().contains("otp")
          ? TextAlign.center
          : TextAlign.left,
      toolbarOptions: const ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      textInputAction: textInputAction,
      obscureText: isObscure,
      onSaved: save,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      keyboardType: textInputType,
      initialValue: initialValue,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        suffix: suffix,
        errorText: error,
        prefixIcon: Icon(
          icon,
          size: iconSize,
        ),
        contentPadding: contentPadding,
        hintText: hint ?? ' ',
        labelText: label ?? ' ',
        suffixIcon: suffixIcon,
        border: InputBorder.none,
      ),
    );
  }
}

class CTextField extends StatelessWidget {
  final String hint;
  final String label;
  final int validateLength;
  final Function(String) onChange;
  final String Function(String) validator;
  final Function(String) save;
  final bool isObscure;
  final TextInputType textInputType;
  final int maxLength;
  final TextEditingController controller;
  final int maxLines;
  final IconData suffixIcon;
  final String initialValue;
  final EdgeInsets padding, contentPadding;
  final Widget suffix;
  final String prefix;
  final InputBorder border;
  final bool enabled;

  const CTextField(
      {Key key,
      this.hint,
      this.label,
      this.validateLength,
      this.save,
      this.isObscure,
      this.maxLength,
      this.controller,
      this.maxLines,
      this.initialValue,
      this.suffixIcon,
      this.enabled,
      this.padding = const EdgeInsets.all(0.0),
      this.suffix,
      this.contentPadding =
          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      this.textInputType,
      this.validator,
      this.onChange,
      this.border,
      this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: padding,
        child: TextFormField(
          onChanged: onChange,
          enabled: enabled,
          scrollPhysics: const PageScrollPhysics(),
          controller: controller,
          validator: validator ??
              (value) {
                if (validateLength == 0) return null;
                if (value == null) return "Invalid input";

                if (value.length < validateLength)
                  return "${label ?? "Input"} must be valid";

                return null;
              },
          textAlign: label.toLowerCase().contains("otp")
              ? TextAlign.center
              : TextAlign.left,
          toolbarOptions: const ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),
          obscureText: isObscure ?? false,
          onSaved: save,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          keyboardType: textInputType,
          initialValue: initialValue,
          decoration: InputDecoration(
              border: border,
              suffix: suffix,
              prefixText: prefix,
              contentPadding: contentPadding,
              hintText: hint ?? ' ',
              labelText: label ?? ' ',
              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null),
        ),
      ),
    );
  }
}
