import 'package:flutter/material.dart';
import 'package:sellpad/widgets/suffix_svg_icon.dart';

import '../utils/Colors.dart';
import 'TextfromFieldWidget.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTextFieldBoxDecoration,
      // width: double.infinity,
      // height: 50.h,
      child: TextFormFieldWidget(
        controller: searchController,
        textInputType: TextInputType.name,
        prefixIcon: SvgIcon(imageName: 'assets/search-button.svg'),
        hintText: 'Search Here',
        obscureText: null,
      ),
    );
  }
}
