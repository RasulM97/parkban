import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
        this.height,
        this.disabledColor,
        this.enableLoading,
        this.margin,
        this.padding,
        this.pressedOpacity,
        this.alignment,
        this.color,
        this.child,
        this.children = const <Widget>[],
        required this.onTap,
        this.width,
        this.radius,
        this.mainAxisAlignment})
      : super(key: key);
  final Widget? child;
  final List<Widget>? children;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double? radius;
  final double? pressedOpacity;
  final bool? enableLoading;
  final Color? color;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? disabledColor;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 50,
          margin: margin,
          child: CupertinoButton(
            disabledColor: disabledColor ?? CupertinoColors.inactiveGray,
            onPressed: enableLoading ?? false ? null : onTap,
            padding: padding,
            pressedOpacity: pressedOpacity ?? .5,
            alignment: alignment ?? Alignment.center,
            color: color ?? CupertinoColors.activeBlue,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.0)),
            child: child != null
                ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
                children: [
                  child!,
                  enableLoading ?? false ? const SizedBox(width: 8) : const SizedBox(width: 0),
                  enableLoading ?? false
                      ? const CupertinoActivityIndicator(
                    radius: 12,
                  )
                      : const SizedBox(width: 0)
                ])
                : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
                children: [
                  ...?children,
                  enableLoading ?? false ? const SizedBox(width: 8) : const SizedBox(width: 0),
                  enableLoading ?? false
                      ? const CupertinoActivityIndicator(
                    radius: 12,
                  )
                      : const SizedBox()
                ]),
          ),
        ),
      );
  }
}
