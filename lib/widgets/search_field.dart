import 'package:flutter/material.dart';
import 'package:Uzaar/widgets/suffix_svg_icon.dart';

import '../utils/Colors.dart';
import 'text_form_field_reusable.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextFormFieldWidget(
        focusedBorder: kRoundedActiveBorderStyle,
        controller: searchController,
        textInputType: TextInputType.name,
        prefixIcon: SvgIcon(imageName: 'assets/search-button.svg'),
        hintText: 'Search Here',
        obscureText: null,
      ),
    );
  }
}
