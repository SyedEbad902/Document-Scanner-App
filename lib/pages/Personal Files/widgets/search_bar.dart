import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffF2F7FF)),
        child: TextFormField(
          // focusNode: _focusNode
          decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIconColor: Color.fromARGB(255, 127, 127, 131),
              labelText: 'Search File',
              labelStyle: TextStyle(color: Color(0xff9694FF)),
              prefixIcon: Icon(
                Icons.search,
                size: 25,
              )),
        ),
      ),
    );
  }
}
