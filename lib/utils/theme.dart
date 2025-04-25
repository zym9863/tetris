import 'package:flutter/material.dart';

/// 游戏主题定义
class TetrisTheme {
  // 主题色
  static const Color primaryColor = Color(0xFF2A2A72);
  static const Color secondaryColor = Color(0xFF009FFD);
  static const Color accentColor = Color(0xFFFF6B6B);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  
  // 方块颜色 - 更现代的配色方案
  static const Map<int, Color> pieceColors = {
    1: Color(0xFF00BCD4),  // I - 青色
    2: Color(0xFF2979FF),  // J - 蓝色
    3: Color(0xFFFF9800),  // L - 橙色
    4: Color(0xFFFFEB3B),  // O - 黄色
    5: Color(0xFF4CAF50),  // S - 绿色
    6: Color(0xFF9C27B0),  // T - 紫色
    7: Color(0xFFF44336),  // Z - 红色
  };
  
  // 容器装饰
  static BoxDecoration containerDecoration = BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(12.0),
    border: Border.all(color: secondaryColor.withOpacity(0.5), width: 2.0),
    boxShadow: [
      BoxShadow(
        color: secondaryColor.withOpacity(0.2),
        blurRadius: 8.0,
        spreadRadius: 1.0,
      ),
    ],
  );
  
  // 游戏板装饰
  static BoxDecoration boardDecoration = BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: secondaryColor.withOpacity(0.7), width: 2.0),
    boxShadow: [
      BoxShadow(
        color: secondaryColor.withOpacity(0.3),
        blurRadius: 10.0,
        spreadRadius: 1.0,
      ),
    ],
  );
  
  // 按钮样式
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    elevation: 5,
    shadowColor: primaryColor.withOpacity(0.5),
  );
  
  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    elevation: 5,
    shadowColor: secondaryColor.withOpacity(0.5),
  );
  
  // 文本样式
  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 48.0,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: secondaryColor,
        blurRadius: 15.0,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );
  
  static const TextStyle subtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: secondaryColor,
        blurRadius: 5.0,
        offset: Offset(1.0, 1.0),
      ),
    ],
  );
  
  static const TextStyle bodyStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle labelStyle = TextStyle(
    color: Colors.white70,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle valueStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  
  // 方块单元格样式
  static BoxDecoration cellDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(
        color: Colors.white.withOpacity(0.3),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.6),
          blurRadius: 4.0,
          spreadRadius: 0.5,
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(1.0),
          color.withOpacity(0.7),
        ],
      ),
    );
  }
  
  // 背景渐变
  static BoxDecoration backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        backgroundColor,
        primaryColor.withOpacity(0.3),
      ],
    ),
  );
}
