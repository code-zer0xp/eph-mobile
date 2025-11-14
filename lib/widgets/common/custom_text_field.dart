import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final EdgeInsets? contentPadding;
  final double borderRadius;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.onTap,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.contentPadding,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmitted,
      focusNode: focusNode,
      autofocus: autofocus,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: enabled ? AppColors.surface : AppColors.lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textLight,
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        counterText: maxLength != null ? null : '',
      ),
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final EdgeInsets? contentPadding;
  final double borderRadius;

  const CustomPasswordTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.contentPadding,
    this.borderRadius = 8.0,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: widget.label,
      hint: widget.hint,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      validator: widget.validator,
      prefixIcon: widget.prefixIcon,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      contentPadding: widget.contentPadding,
      borderRadius: widget.borderRadius,
    );
  }
}
