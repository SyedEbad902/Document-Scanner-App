import 'package:flutter/material.dart';
import 'package:pdf_scanner/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isClick ? Color(0xff121212) : Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: themeProvider.isClick
            ? const Color(0xff5A5899)
            : const Color(0xff9694FF),
      ),
      body: const Center(
        child: Text("Accounts Page"),
      ),
    );
  }
}
