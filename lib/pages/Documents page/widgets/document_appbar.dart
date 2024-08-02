import 'package:flutter/material.dart';

class DocumentAppBar extends StatelessWidget {
  const DocumentAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.settings,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
