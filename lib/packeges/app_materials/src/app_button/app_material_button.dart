part of '../../material.dart';

class AppMaterialButton extends StatelessWidget {
  const AppMaterialButton({
    required this.buttonText,
    this.onPressed,
    this.buttonColor,
    super.key,
  });

  final VoidCallback? onPressed;
  final String buttonText;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor ?? AppColors.brown,
      autofocus: true,
      disabledColor: AppColors.lightBrown,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyles.extraBold(
          fontSize: Dimensions.large,
          color: AppColors.primary7,
        ),
      ),
    );
  }
}
