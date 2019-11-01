import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchButton extends StatelessWidget {
  final TextEditingController searchController;
  final Widget searchIcon;
  final String title;

  SearchButton({
    Key key,
    @required this.searchController,
    @required this.searchIcon,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        prefixIcon: searchIcon,
        hintText: title,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        filled: true,
      ),
    );
  }
}
