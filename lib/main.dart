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

// 追加: 認証関連画面';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/register_screen.dart';
import 'package:myapp/screens/settings_screen.dart';

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
        // 設定画面（ボトムナビが必要ならここ、不要なら下に独立で）
        GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
        // TODO: 履歴画面などを追加する場合はここに
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
        final id = state.pathParameters['id'] ?? '';
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
    // 追加: 認証系ルート
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brand = Color.fromARGB(255, 251, 189, 74); // #FFD363
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: brand,
        brightness: Brightness.light,
        ).copyWith(primary: brand,
        ),
      iconTheme: const IconThemeData(color: brand),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: brand),
      textTheme: GoogleFonts.notoSansJpTextTheme(),
    );

    return MaterialApp.router(
      title: 'myapp',
      theme: theme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}