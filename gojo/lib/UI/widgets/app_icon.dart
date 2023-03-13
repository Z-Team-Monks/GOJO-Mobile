import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gojo/resources/resources.dart';

class GojoAppIcon extends StatelessWidget {
  final double? height;
  const GojoAppIcon({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Resources.gojoImages.appIconSvg,
      semanticsLabel: 'App Icon',
      height: height ?? 100,
    );
  }
}
