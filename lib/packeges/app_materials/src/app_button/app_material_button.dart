part of '../../material.dart';

class AppMaterialButton extends StatelessWidget {
  const AppMaterialButton({
    required this.buttonText,
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColor.brown,
      autofocus: true,
      disabledColor:AppColor.lightBrown,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyles.extraBold(
          fontSize: Dimensions.large.sp,
          textColor: AppColor.primary7,
        ),
      ),
    );
  }
}
