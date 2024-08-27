import 'package:flutter/material.dart';
import 'package:pdf_scanner/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

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
          // const CircleAvatar(
          //   radius: 17,
          //   backgroundColor: Colors.black,
          // )
IconButton(
            onPressed: () {
              // Get the ThemeProvider instance from the context
              final themeProvider =
                  Provider.of<ThemeProvider>(context, listen: false);

              // Call the toggleTheme method to change the theme
              themeProvider.toggleTheme();
            },
            icon: Icon(
              // Use the isClick to determine the icon
              provider.isClick ? Icons.light_mode : Icons.dark_mode,
              size: 30,
            ),
            color: provider.isClick ? Colors.white : Colors.black,
          )
          // IconButton(
          //   onPressed: () {
          //     setState(() {
          //       provider.isClick = !provider.isClick;
          //     });
          //     provider.setTheme();
             
          //   },
          //   icon: Icon(
          //     provider.isClick ? Icons.light_mode : Icons.dark_mode,
          //     size: 30,
          //   ),
          //   color: provider.isClick ? Colors.white : Colors.black,
          // )
        ],
      ),
    );
  }
}
