import 'package:dummy_1/utils/exports.dart';

enum MainButtonType { main }

class MainButton extends StatelessWidget {
  MainButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.type = MainButtonType.main,
    this.hasBottomMargin = false,
    this.isDisable = false,
    this.borderRadius,
    this.borderSide,
    this.minimumSize,
    this.buttonColor = AppColors.primary,
    this.fontColor = AppColors.white,
    this.padding,
    this.margin,
    this.alignment,
    this.isLoading = false,
    this.fontSize = 18,
    this.isIconAtStart = false,
  }) {
    _child = Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        color: fontColor,
      ),
    );
  }

  MainButton.icon({
    required this.onPressed,
    required Widget icon,
    this.text = '',
    Widget? child,
    this.type = MainButtonType.main,
    this.hasBottomMargin = false,
    this.isDisable = false,
    this.borderRadius,
    this.borderSide,
    this.minimumSize,
    this.buttonColor = AppColors.primary,
    this.fontColor = AppColors.white,
    this.padding,
    this.margin,
    this.alignment,
    this.isIconAtStart = false,
    this.fontSize = 20,
    double horizontalSpace = 12,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    super.key,
    this.isLoading = false,
  }) {
    _child = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        child ?? const SizedBox.shrink(),
        SizedBox(width: horizontalSpace),
        if (isIconAtStart) icon,
        horizontalSpace.widthBox,
        if (text.isNotEmpty && child == null)
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: fontColor,
            ),
          ),
        SizedBox(width: horizontalSpace),
        if (!isIconAtStart) icon,
      ],
    );
  }

  late final Widget? _child;
  final bool isIconAtStart;
  final Function onPressed;
  final String text;
  final MainButtonType type;
  final bool hasBottomMargin;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? borderSide;
  final Size? minimumSize;
  final Color buttonColor;
  final Color fontColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final bool isDisable;
  final bool isLoading;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: margin ??
            (hasBottomMargin
                ? const EdgeInsets.only(bottom: 20)
                : EdgeInsets.zero),
        child: ElevatedButton(
          onPressed: isDisable ? null : () => onPressed.call(),
          style: ElevatedButton.styleFrom(
            padding: padding ?? EdgeInsets.zero,
            backgroundColor: isDisable ? AppColors.white : buttonColor,
            shadowColor: Colors.transparent,
            alignment: alignment,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(30),
              side: borderSide ?? BorderSide.none,
            ),
            minimumSize: minimumSize ??
                const Size(
                  double.infinity,
                  56,
                ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2,
                  ),
                )
              : _child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
