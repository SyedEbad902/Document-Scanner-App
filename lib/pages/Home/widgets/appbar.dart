
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      height: 70,
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // num num1 = 0.2;
             
              // print(_diceface);
            },
            child: const Icon(
              Icons.menu,
              size: 28,
            ),
          ),

          // ),
          const CircleAvatar(
            radius: 17,
            backgroundColor: Colors.black,
          )
        ],
      ),
    );
  }
}
