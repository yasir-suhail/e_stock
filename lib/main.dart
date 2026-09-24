import 'package:e_stock/splash_screen.dart';
import 'package:e_stock/view_Model/auth_viewmodel.dart';
import 'package:e_stock/view_Model/product_viewModel.dart';
import 'package:e_stock/view_Model/profile_viewmodel.dart';
import 'package:e_stock/view_Model/stock_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
          ),

          // ChangeNotifierProvider(
          //   create: (_) => ProfileViewmodel(),
          // ),
          ChangeNotifierProvider(
              create: (_) => ProfileViewmodel()..loadOwnerData(),
          ),

          // ChangeNotifierProvider(
          //   create: (_) => ProductViewmodel(),
          // ),
          ChangeNotifierProvider(
            create: (_) => ProductViewmodel()..getProducts(),
          ),
          ChangeNotifierProvider(
            create: (_) => StockViewmodel(),
          ),
        ],
        child: const MyApp(),
      )
  );
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   print('1. Before Firebase');
//
//   await Firebase.initializeApp(
//   );
//
//   print('2. Firebase initialized');
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => AuthViewModel(),
//         ),
//         ChangeNotifierProvider(
//           create: (_) => ProfileViewmodel(),
//         ),
//         ChangeNotifierProvider(
//           create: (_) => ProductViewmodel(),
//         ),
//         ChangeNotifierProvider(
//           create: (_) => StockViewmodel(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
//
//   print('3. runApp called');
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Inter',
      ),
      // home:LoadVanScreen(isOwnerView: true)
      home: SplashScreen(),
    );
  }
}
