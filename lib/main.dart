import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_scanner/pages/Documents%20page/documents_screen.dart';
import 'package:pdf_scanner/pages/Pdf%20Files/pdf_files.dart';
import 'package:pdf_scanner/pages/Personal%20Files/personal_file.dart';
import 'package:pdf_scanner/provider/home_screen_provider.dart';
import 'package:pdf_scanner/provider/theme_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'navbar/my_nav_bar.dart';
import 'pages/Docx Files/docx_files.dart';
import 'pages/splash_screen.dart';
import 'provider/document_screen_provider.dart';
import 'provider/navigation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await requestPermissions().then((_) {
    runApp(const MyApp());
  });
}

Future<void> requestPermissions() async {
  await Permission.storage.request();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MultiProvider to provide multiple providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DocumentScreenProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      // Access the ThemeProvider here to use the themeState
      child: Builder(
        builder: (context) {
          final provider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            themeMode: provider.themeState,
            theme:ThemeData.light(),
            darkTheme: ThemeData(brightness: Brightness.dark),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/second': (context) => const MyNavBar(),
              '/personalFiles': (context) => const GetFiles(),
              '/pdfFiles': (context) => const PdfFiles(),
              '/docxFiles': (context) => const DocxFiles(),
              '/documentScr': (context) => const DocumentScreen(),
            },
          );
        },
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context)  => MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_) => HomeProvider()),
//           ChangeNotifierProvider(create: (_) => DocumentScreenProvider()),
//           ChangeNotifierProvider(create: (_) => NavigationProvider()),
//           ChangeNotifierProvider(create: (_) => ThemeProvider()),
//         ],
//           final provider = Provider.of<ThemeProvider>(context);
  
//         child:  MaterialApp(
//            themeMode:provider.themeState,
//           darkTheme: ThemeData(brightness: Brightness.dark),
//           debugShowCheckedModeBanner: false,
//                 initialRoute: '/',
//       routes: {
//         '/': (context) => SplashScreen(),
//         '/second': (context) => MyNavBar(),
//         '/personalFiles': (context) => GetFiles(),
//         '/pdfFiles': (context) => PdfFiles(),
//         '/docxFiles': (context) => DocxFiles(),
//         '/documentScr': (context) =>  DocumentScreen(),

//       },
//           // home: SplashScreen(),
//         ),
//       );
// }
