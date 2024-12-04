import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../utils/app_colors.dart';

/// App text form field

enum FormFieldType {
  textField,
  dropDown,
}

/// App Text filed
class AppTextFormField<T> extends StatelessWidget {
  /// Construct app files
  const AppTextFormField({
    required this.name,
    this.title,
    this.formFieldType = FormFieldType.textField,
    this.hintText,
    this.showHint = false,
    this.validate,
    this.preFixIcon,
    this.hintStyle,
    this.keyboardType = TextInputType.text,
    this.autoFillHints,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.onChange,
    this.letterSpacing = 0,
    this.maxLength = 225,
    this.initialValue,
    this.enabled = true,
    this.suffixIcon,
    this.fontSize,
    this.errorText,
    this.mandate = false,
    this.hasBorder = false,
    this.minLines,
    this.maxLines = 1,
    this.bottomMargin = 12,
    this.textFieldHeight = 147,
    this.fillColor = AppColors.white,
    this.borderColor = Colors.transparent,
    this.hasLabel = false,
    this.rightSidePadding = 0,
    this.enableColor,
    this.textInputAction = TextInputAction.next,
    this.cursorHeight,
    this.fontStyle,
    this.showCursor = true,
    this.isUpperCaseAll = false,
    this.labelText,
    this.contentPadding,
    this.inputFormatter,
    this.labelStyle,
    this.autoFocus = false,
    this.preFixWidget,
    this.suffixWidget,
    this.isShowLabel = false,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius = 12,
    this.prefixWidgetSize,
    this.suffixWidgetSize,
    this.constraints,
    this.counter,
    this.dropDownItems,
    this.isObscure = false,
    this.showBorderRadius = false,
    super.key,
    this.textStyle,
  });

  /// Set true if the field is mandatory. It will add an Asterisk in the
  /// end of the label
  final bool mandate;

  ///Hint text
  final String? hintText;

  /// Show / hide the hint text
  final bool showHint;

  /// isObscure
  final bool isObscure;

  ///Validate
  final String? Function(dynamic value)? validate;

  ///Prefix
  final Widget? preFixIcon;

  ///Prefix Widget
  final Widget? preFixWidget;

  /// Keyboard type of the text field
  final TextInputType keyboardType;

  ///List of autofill hints
  final List<String>? autoFillHints;

  ///Read only
  final bool readOnly;

  ///Read only
  final bool enabled;

  ///Show BorderRadius
  final bool showBorderRadius;

  ///BorderRadius
  final double borderRadius;

  /// Enable Color
  final Color? enableColor;

  ///On tap
  final VoidCallback? onTap;

  ///Controller
  final TextEditingController? controller;

  ///Function of On change
  final void Function(dynamic)? onChange;

  ///Letter Spacing
  final double letterSpacing;

  ///Maximum Length
  final int? maxLength;

  ///initial Value
  final T? initialValue;

  ///Suffix icon
  final Widget? suffixIcon;

  ///Font Size of hintText
  final double? fontSize;

  /// Min lines of Text
  final int? minLines;

  /// Has Label
  final bool hasLabel;

  /// Min lines of Text
  final int? maxLines;

  ///Error Text
  final String? errorText;

  ///bottom Margin
  final double bottomMargin;

  ///Set height using [textFieldHeight] default is : 147 logical pixel
  final double textFieldHeight;

  ///TextFormField Background Color
  final Color fillColor;

  ///Input TextStyle
  final TextStyle? hintStyle;

  ///Input TextStyle
  final TextStyle? fontStyle;

  ///TextFormField Border Color
  final Color borderColor;

  ///Has Border
  final bool hasBorder;

  ///TextFormField Content Padding
  final double rightSidePadding;

  ///TextFormField cursor height
  final double? cursorHeight;

  ///Text Input Action
  final TextInputAction? textInputAction;

  /// true if want to show cursor
  final bool showCursor;

  final bool isUpperCaseAll;

  /// Label Text
  final String? labelText;

  /// Label Style
  final TextStyle? labelStyle;

  /// Suffix Widget
  final Widget? suffixWidget;

  /// Auto focus
  final bool autoFocus;

  /// show label initially
  final bool isShowLabel;

  final TextCapitalization textCapitalization;

  final EdgeInsetsGeometry? contentPadding;

  final List<TextInputFormatter>? inputFormatter;

  /// Prefix Icon Box constrain
  final Size? prefixWidgetSize;
  final Size? suffixWidgetSize;

  /// Text-field constraints
  final BoxConstraints? constraints;

  /// Text field key name
  final String name;
  final String? title;
  final TextStyle? textStyle;

  /// Counter widget
  final Widget? counter;

  /// Form field type default is [FormFieldType.textField]
  final FormFieldType formFieldType;

  /// List of DropdownItems
  final List<DropdownMenuItem<T>>? dropDownItems;

  @override
  Widget build(BuildContext context) {
    switch (formFieldType) {
      case FormFieldType.textField:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: textStyle,
              ),
              const SizedBox(
                height: 8,
              )
            ],
            FormBuilderTextField(
              obscureText: isObscure,
              name: name,
              textCapitalization: textCapitalization,
              autofocus: autoFocus,
              inputFormatters: isUpperCaseAll
                  ? <TextInputFormatter>[
                      TextInputFormatter.withFunction(
                        (TextEditingValue oldValue,
                                TextEditingValue newValue) =>
                            TextEditingValue(
                          text: newValue.text.toUpperCase(),
                          selection: newValue.selection,
                        ),
                      )
                    ]
                  : inputFormatter,
              readOnly: readOnly,
              maxLength: maxLength,
              maxLines: maxLines,
              minLines: minLines,
              onTap: onTap,
              controller: controller,
              enabled: enabled,
              cursorColor: AppColors.primary,
              style: fontStyle ??
                  const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
              showCursor: showCursor,
              decoration: _buildInputDecoration(),
              keyboardType: keyboardType,
              validator: validate,
              autofillHints: autoFillHints,
              textInputAction: textInputAction,
              onChanged: onChange,
              initialValue: initialValue?.toString(),
            ),
          ],
        );
      case FormFieldType.dropDown:
        return FormBuilderDropdown<T>(
          name: name,
          autofocus: autoFocus,
          onTap: onTap,
          enabled: enabled,
          style: fontStyle ??
              const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 30,
          ),
          decoration: _buildInputDecoration(),
          validator: validate,
          onChanged: onChange,
          initialValue: initialValue,
          items: dropDownItems ?? [],
        );
    }
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      counter: counter,
      labelStyle: isShowLabel ? labelStyle : fontStyle,
      labelText: isShowLabel ? labelText : null,
      hintText: hasLabel ? null : hintText,
      fillColor: fillColor,
      hintStyle: hintStyle ??
          const TextStyle(
            fontSize: 14,
            color: AppColors.grey200,
          ),
      prefixIcon: preFixIcon,
      suffixIcon: suffixIcon,
      suffix: suffixWidget,
      counterText: '',
      prefix: preFixWidget,
      prefixIconConstraints:
          BoxConstraints.tight(prefixWidgetSize ?? const Size(50, 50)),
      suffixIconConstraints:
          BoxConstraints.tight(suffixWidgetSize ?? const Size(50, 50)),
      constraints: constraints,
      border: _buildBorder(),
      focusedErrorBorder: _buildBorder(),
      enabledBorder: _buildBorder(),
      disabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(),
      errorBorder: _buildBorder(),
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }

  InputBorder _buildBorder() => UnderlineInputBorder(
        borderSide: hasBorder ? const BorderSide() : BorderSide.none,
        borderRadius: showBorderRadius
            ? BorderRadius.circular(borderRadius)
            : const BorderRadius.only(),
      );
}
