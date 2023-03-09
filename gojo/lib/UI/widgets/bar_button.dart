import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/borders.dart';

class GojoBarButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final bool loadingState;
  final double? customWidth;
  final double? customHeight;
  final double? fontSize;

  const GojoBarButton({
    Key? key,
    required this.title,
    required this.onClick,
    this.loadingState = false,
    this.customWidth,
    this.customHeight,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customHeight ?? 55,
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                GojoBorderRadius.radius(GojoBorderRadiusSize.small),
              ),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loadingState == true
                ? SizedBox(
                    width: 28.5,
                    height: 28.5,
                    child: CircularProgressIndicator(
                      color: Colors.white.withOpacity(0.25),
                    ))
                : const SizedBox(),
            loadingState == true
                ? const SizedBox(width: 14.75)
                : const SizedBox(),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
