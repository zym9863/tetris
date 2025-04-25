import 'package:flutter/material.dart';
import '../game/tetris_game.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class NextPieceWidget extends StatelessWidget {
  final TetrisGame game;

  const NextPieceWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    // 根据屏幕大小调整容器尺寸
    final containerSize = isSmallScreen ? 100.0 : 120.0;

    return Container(
      width: containerSize,
      height: containerSize,
      padding: const EdgeInsets.all(12.0),
      decoration: TetrisTheme.containerDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '下一个',
            style: TetrisTheme.labelStyle.copyWith(
              color: TetrisTheme.secondaryColor,
            ),
          ),
          const SizedBox(height: 12.0),
          _buildNextPiecePreview(),
        ],
      ),
    );
  }

  Widget _buildNextPiecePreview() {
    if (game.nextPiece == null) {
      return const SizedBox(width: 60, height: 60);
    }

    final shape = game.nextPiece!.shape;
    final type = game.nextPiece!.type;
    final color = kPieceColors[type]!;

    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: shape[0].length,
        ),
        itemCount: shape.length * shape[0].length,
        itemBuilder: (context, index) {
          final row = index ~/ shape[0].length;
          final col = index % shape[0].length;

          // 使用主题中定义的单元格样式
          if (shape[row][col] != 0) {
            return Container(
              margin: const EdgeInsets.all(1.0),
              decoration: TetrisTheme.cellDecoration(color),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(color: Colors.transparent),
            );
          }
        },
      ),
    );
  }
}
