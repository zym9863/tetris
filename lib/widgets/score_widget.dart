import 'package:flutter/material.dart';
import '../game/tetris_game.dart';
import '../utils/theme.dart';

class ScoreWidget extends StatelessWidget {
  final TetrisGame game;

  const ScoreWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    // 根据屏幕大小调整容器尺寸
    final containerWidth = isSmallScreen ? 100.0 : 120.0;

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.all(12.0),
      decoration: TetrisTheme.containerDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInfoItem('分数', '${game.score}', Icons.score),
          const SizedBox(height: 16.0),
          _buildInfoItem('等级', '${game.level}', Icons.trending_up),
          const SizedBox(height: 16.0),
          _buildInfoItem('行数', '${game.linesCleared}', Icons.clear_all),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: TetrisTheme.secondaryColor, size: 20.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TetrisTheme.labelStyle),
              const SizedBox(height: 4.0),
              Text(value, style: TetrisTheme.valueStyle),
            ],
          ),
        ),
      ],
    );
  }
}
