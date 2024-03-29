import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:dogs_app/ui/common/shared_styles.dart';
import 'package:dogs_app/ui/common/widgets/ra_skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui_helpers.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.placeholder,
    this.contentPadding = const EdgeInsets.only(
      left: 16,
      top: 38,
      bottom: 0,
      right: 10,
    ),
    this.isPlaceholder = false,
    this.errorMessage = "This field can't be empty",
    this.loading = false,
    this.hasShadow = false,
    this.hasError = false,
    this.hasFieldHight = true,
    this.placeholderColor,
    this.backgroundColor,
    this.enterPressed,
    this.expands = false,
    this.fieldFocusNode,
    this.hasFocusedBorder = false,
    this.nextFocusNode,
    this.onChanged,
    this.inputFormatter = const [],
    this.autoFocus = false,
    this.hasInputDecoration = true,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.isReadOnly = false,
    this.smallVersion = false,
    this.fieldHeight = 58.0,
    this.maxTextLimit,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.maxLine,
    this.boxDecoration,
    this.hasBoxDecoration = true,
    this.textAlignVertical = TextAlignVertical.center,
    this.showCounterText = true,
    this.onTap,
    this.blendTextForm = false,
    this.onFieldSubmitted,
    this.borderColor,
    this.labelText,
    this.focusedBorderRadius,
    this.floatingLabelText,
    this.textStyle,
    this.showErrorMessage = false,
    this.focusedBorderColor = kcPrimaryColor,
    this.counter,
    Key? key,
  }) : super(key: key);

  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final bool autoFocus;
  final bool showErrorMessage;
  final bool loading;
  final bool hasShadow;
  final bool isPlaceholder;
  final bool blendTextForm;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color focusedBorderColor;
  final BoxDecoration? boxDecoration;
  final EdgeInsetsGeometry contentPadding;
  final TextEditingController controller;
  final Function? enterPressed;
  final bool expands;
  final FocusNode? fieldFocusNode;
  final double fieldHeight;
  final String? floatingLabelText;
  final String? counter;
  final BorderRadius? focusedBorderRadius;
  final bool hasBoxDecoration;
  final bool hasError;
  final bool hasFieldHight;
  final bool hasFocusedBorder;
  final bool hasInputDecoration;
  final Color? iconColor;
  final List<TextInputFormatter> inputFormatter;
  final bool isReadOnly;
  final String? labelText;
  final int? maxLine;
  final int? maxTextLimit;
  final FocusNode? nextFocusNode;
  final bool password;
  final String placeholder;
  final Color? placeholderColor;
  final Widget? prefixIcon;
  final bool showCounterText;
  final bool smallVersion;
  final Widget? suffixIcon;
  final TextAlignVertical textAlignVertical;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String? validationMessage;
  final TextStyle? textStyle;
  final String? errorMessage;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isPassword = false;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: widget.isReadOnly ? 0.3 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.floatingLabelText != null) ...[
                Text(
                  '  ${widget.floatingLabelText!}',
                  style: ktsDarkSmall(context).copyWith(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                verticalSpaceTiny,
              ],
              Container(
                height: widget.hasFieldHight ? widget.fieldHeight : null,
                alignment: Alignment.centerLeft,
                decoration: widget.boxDecoration ??
                    BoxDecoration(
                      boxShadow: widget.hasShadow
                          ? [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(
                                  0, // This is from X direction
                                  3, // This is from Y direction
                                ), // changes position of the shadow to the given direction
                              )
                            ]
                          : null,
                      border: widget.hasError
                          ? Border.all(color: kcErrorColor)
                          : null,
                      borderRadius: BorderRadius.all(
                        widget.blendTextForm
                            ? const Radius.circular(6)
                            : widget.hasError
                                ? const Radius.circular(6)
                                : Radius.zero,
                      ),
                    ),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: widget.boxDecoration ??
                        const BoxDecoration(
                          // border: widget.hasError ? Border.all(color: kcRed) : null,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                    clipBehavior: widget.boxDecoration != null
                        ? Clip.antiAlias
                        : Clip.none,
                    child: RASkeletonLoader(
                      loading: widget.loading,
                      child: AbsorbPointer(
                        absorbing: widget.isPlaceholder || widget.isReadOnly,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: widget.textStyle ??
                                    ktsDarkGreyTextStyle(context)
                                        .copyWith(fontSize: 15, color: kcWhite),
                                textCapitalization: widget.textInputType !=
                                        TextInputType.emailAddress
                                    ? TextCapitalization.sentences
                                    : TextCapitalization.none,
                                textAlignVertical: widget.textAlignVertical,
                                expands: widget.expands,
                                maxLines: widget.maxLine,
                                maxLength: widget.maxTextLimit,
                                inputFormatters: widget.inputFormatter,
                                autofocus: widget.autoFocus,
                                autocorrect: true,
                                controller: widget.controller,
                                keyboardType: widget.textInputType,
                                focusNode: widget.fieldFocusNode,
                                textInputAction: widget.textInputAction,
                                onChanged: widget.onChanged,
                                obscureText: isPassword,
                                onTap: widget.onTap,
                                onEditingComplete: () {
                                  if (widget.enterPressed != null) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    widget.enterPressed!();
                                  }
                                  if (widget.nextFocusNode != null) {
                                    widget.nextFocusNode!.nextFocus();
                                  } else {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                onFieldSubmitted: widget.onFieldSubmitted ??
                                    (value) {
                                      if (widget.nextFocusNode != null) {
                                        widget.nextFocusNode!.requestFocus();
                                      }
                                    },
                                readOnly: widget.isReadOnly,
                                decoration: InputDecoration(
                                  filled: true,
                                  counterText: !widget.showCounterText
                                      ? ""
                                      : widget.counter,
                                  counterStyle: ktsSmall(context),
                                  enabledBorder: widget.hasInputDecoration
                                      ? OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: widget.borderColor ??
                                                  kcLightBlue,
                                              width: 1.2),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        )
                                      : null,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: widget.hasFocusedBorder
                                        ? BorderSide(
                                            color: widget.hasFocusedBorder &&
                                                    !widget.isReadOnly
                                                ? widget.focusedBorderColor
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .tertiaryContainer,
                                            width: 1.2)
                                        : const BorderSide(
                                            color: Colors.transparent,
                                            width: 1.2),
                                    borderRadius: widget.focusedBorderRadius ??
                                        BorderRadius.circular(6),
                                  ),
                                  prefixIcon: widget.prefixIcon,
                                  suffixIcon: widget.suffixIcon ??
                                      (widget.password
                                          ? GestureDetector(
                                              onTap: () => setState(() {
                                                isPassword = !isPassword;
                                              }),
                                              child: widget.password
                                                  ? Icon(
                                                      isPassword
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      size: 22,
                                                    )
                                                  : Container(),
                                            )
                                          : null),
                                  border: InputBorder.none,
                                  labelText: widget.labelText,
                                  floatingLabelStyle: ktsSmall(context),
                                  labelStyle: ktsRegular(context)
                                      .copyWith(fontSize: 17),
                                  hintText: widget.placeholder,
                                  hintStyle: ktsRegular(context).copyWith(
                                    fontSize: 17,
                                    color: widget.isPlaceholder
                                        ? kcDarkGreyColor
                                        : widget.placeholderColor ??
                                            Theme.of(context)
                                                .colorScheme
                                                .tertiaryContainer,
                                  ),
                                  contentPadding: widget.contentPadding,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.showErrorMessage)
          Text(
            widget.errorMessage!,
            style: ktsSmall(context)
                .copyWith(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }
}
