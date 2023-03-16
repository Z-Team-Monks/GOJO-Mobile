import 'package:flutter/material.dart';

enum GojoBorderRadiusSize {
  small,
  medium,
  large,
}

class GojoBorderRadius {
  static Radius radius(GojoBorderRadiusSize type) {
    switch (type) {
      case GojoBorderRadiusSize.small:
        return const Radius.circular(5);
      case GojoBorderRadiusSize.medium:
        return const Radius.circular(10);
      case GojoBorderRadiusSize.large:
        return const Radius.circular(15);
    }
  }
}

class GojoBorders {
  static OutlineInputBorder rounded(GojoBorderRadiusSize type,
      {BorderSide borderSide = BorderSide.none}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        GojoBorderRadius.radius(type),
      ),
      borderSide: borderSide,
    );
  }

  static BorderRadiusGeometry border(GojoBorderRadiusSize type) {
    switch (type) {
      case GojoBorderRadiusSize.small:
        return BorderRadius.circular(5);
      case GojoBorderRadiusSize.medium:
        return BorderRadius.circular(10);
      case GojoBorderRadiusSize.large:
        return BorderRadius.circular(15);
    }
  }
}
