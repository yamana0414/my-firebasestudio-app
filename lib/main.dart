import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:image_picker/image_picker.dart'; // XFileのために追加

// 画面ファイルをインポート
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/scan_screen.dart';
import 'package:myapp/screens/analysis_screen.dart';
import 'package:myapp/screens/result_screen.dart';
import 'package:myapp/screens/item_screen.dart';
import 'package:myapp/screens/condition_screen.dart';
import 'package:myapp/screens/prepare_screen.dart';
import 'package:myapp/screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// GoRouterのインスタンスを作成
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    // ShellRouteを定義
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MainShell(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        // TODO: 履歴画面と設定画面のルートを追加
      ],
    ),
    // ボトムナビゲーションバーが不要な画面
    GoRoute(
      path: '/scan',
      builder: (BuildContext context, GoRouterState state) {
        final XFile? imageFile = state.extra as XFile?; // extraとしてXFileを受け取る
        return ScanScreen(imageFile: imageFile);
      },
    ),
    GoRoute(
      path: '/analysis',
      builder: (BuildContext context, GoRouterState state) {
        return const AnalysisScreen();
      },
    ),
    GoRoute(
      path: '/result',
      builder: (BuildContext context, GoRouterState state) {
        return const ResultScreen();
      },
    ),
    GoRoute(
      path: '/item/:id',
      builder: (BuildContext context, GoRouterState state) {
        final String id = state.pathParameters['id']!;
        return ItemScreen(id: id);
      },
    ),
    GoRoute(
      path: '/condition',
      builder: (BuildContext context, GoRouterState state) {
        return const ConditionScreen();
      },
    ),
    GoRoute(
      path: '/prepare',
      builder: (BuildContext context, GoRouterState state) {
        return const PrepareScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFFFD600);
    const Color backgroundColor = Color(0xFFF5F5F5);
    const Color textColor = Color(0xFF333333);

    return MaterialApp.router(
      title: 'AI Room Scan',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          background: backgroundColor,
          onBackground: textColor,
        ),
        textTheme: GoogleFonts.notoSansJpTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          displayLarge: const TextStyle(fontWeight: FontWeight.bold, color: textColor),
          headlineLarge: const TextStyle(fontWeight: FontWeight.bold, color: textColor),
          titleLarge: const TextStyle(fontWeight: FontWeight.bold, color: textColor),
          bodyLarge: const TextStyle(color: textColor),
          bodyMedium: const TextStyle(color: Colors.black54),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: textColor,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: textColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
      ),
      routerConfig: _router,
    );
  }
}
