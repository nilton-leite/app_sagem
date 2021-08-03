import 'package:flutter/material.dart';

class DynamicIcon extends Icon {
  DynamicIcon(
    String icon, {
    Key key,
    double size,
    Color color,
    TextDirection textDirection,
  })  : iconName = icon,
        super(
          IconData(
            0,
            fontFamily: 'MaterialIcons',
          ),
          key: key,
          size: size,
          color: color,
          semanticLabel: icon,
          textDirection: textDirection,
        );

  final String iconName;

  @override
  Widget build(BuildContext context) {
    print(size);
    print(color);
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final TextDirection textDirection =
        this.textDirection ?? Directionality.of(context);

    final IconThemeData iconTheme = IconTheme.of(context);

    final iconSize = (size ?? iconTheme.size);

    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    final iconOpacity = iconTheme.opacity;
    var iconColor = color ?? iconTheme.color;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    Widget iconWidget = RichText(
      overflow: TextOverflow.visible,
// Never clip.

      textDirection: textDirection,
// Since we already fetched it for the assert...

      text: TextSpan(
        text: iconName,
        style: TextStyle(
          inherit: false,
          color: iconColor,
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      ),
    );

    if (icon.matchTextDirection) {
      switch (textDirection) {
        case TextDirection.rtl:
          iconWidget = Transform(
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconWidget,
          );
          break;
        case TextDirection.ltr:
          break;
      }
    }

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Center(
            child: iconWidget,
          ),
        ),
      ),
    );
  }
}
