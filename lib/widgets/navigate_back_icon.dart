import 'package:flutter/material.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';

class NavigateBack extends StatelessWidget {
  final BuildContext buildContext;
  final ColorFilter? colorFilter;
  NavigateBack({required this.buildContext, this.colorFilter});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(buildContext),
      child: SvgIcon(
        imageName: 'assets/back-arrow-button.svg',
        colorFilter: colorFilter,
      ),
    );
  }
}
