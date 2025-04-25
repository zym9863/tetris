import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置屏幕方向为竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '俄罗斯方块',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: TetrisTheme.primaryColor,
          primary: TetrisTheme.primaryColor,
          secondary: TetrisTheme.secondaryColor,
          background: TetrisTheme.backgroundColor,
          surface: TetrisTheme.surfaceColor,
        ),
        scaffoldBackgroundColor: TetrisTheme.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: TetrisTheme.surfaceColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: TetrisTheme.secondaryColor.withOpacity(0.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TetrisTheme.primaryButtonStyle,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
