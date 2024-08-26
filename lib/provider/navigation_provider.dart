import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationProvider with ChangeNotifier {
  // This function can be called to navigate to a different screen
  void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  // Another example function that can replace the current screen
  void replaceWith(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

   static NavigationProvider of(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<NavigationProvider>(
      context,
      listen: listen,
    );
  }
}
