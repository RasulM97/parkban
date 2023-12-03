import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:parkban/data/database/theme/store_theme.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(
            color: ThemeStorage.readFromBox('theme') ? const Color(0xBF1E1E1E) : const Color(0xCCF2F2F2),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
            ),
          ),
        ),
      ),
    );
  }
}
