part of '../../material.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    this.onChanged,
    this.decoration,
    this.validator,
    this.controller,
    this.contentPadding,
    this.fontSize,
    this.textColor,
    this.labelText,
    this.label,
    this.hintText,
    this.maxLines,
    this.obscureText = false,
    this.inputFormatters,
    this.autovalidateMode,
    this.maxErrorLines,
  });

  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final double? contentPadding;
  final double? fontSize;
  final Color? textColor;
  final String? labelText;
  final Widget? label;
  final String? hintText;
  final int? maxLines;
  final int? maxErrorLines;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      maxLines: widget.maxLines ?? 1,
      obscureText: obscureText,cursorColor: AppColors.brown,
      autovalidateMode: widget.autovalidateMode,
      decoration: widget.decoration ??
          InputDecoration(
            errorMaxLines: widget.maxErrorLines,
            labelStyle: TextStyles.regular(
              fontSize: widget.fontSize ?? Dimensions.large,
              color: widget.textColor ?? AppColors.brown,
            ),
            contentPadding: EdgeInsets.all(widget.contentPadding ?? 12),
            labelText: widget.labelText,
            label: widget.label,
            hintText: widget.hintText,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightBrown),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.lightBrown),
            ),
            focusColor: AppColors.darkBrown,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.brown, width: 1.5),
            ),
            suffixIcon: !widget.obscureText
                ? null
                : InkWell(
                    onTap: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
      inputFormatters: widget.inputFormatters,
      style: TextStyles.regular(
        fontSize: widget.fontSize ?? Dimensions.large,
        color: widget.textColor ?? AppColors.black,
      ),
      validator: widget.validator,
      controller: widget.controller,
    );
  }
}
