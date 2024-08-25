import 'package:flutter/material.dart';
import 'package:pdf_scanner/provider/home_screen_provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = HomeProvider.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        // margin: EdgeInsets.only(bottom: 5),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffF2F7FF),
          // Colors.blue
        ),
        child: TextFormField(
          onChanged: (value) {
            homeProvider.updateSearchQuery(value);
          },
          // focusNode: _focusNode
          decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIconColor: Color.fromARGB(255, 127, 127, 131),
              // labelText: 'Search File',
              hintText: "Search Files",
              hintStyle: TextStyle(fontSize: 15, color: Color(0xff9694FF)),
              prefixIcon: Icon(
                Icons.search,
                size: 25,
              )),
        ),
      ),
    );
  }
}
