import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../game/tetris_game.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class BoardWidget extends StatelessWidget {
  final TetrisGame game;

  const BoardWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    // 计算游戏板宽度 - 在小屏幕上使用屏幕宽度的80%，最大不超过300
    final boardWidth =
        screenSize.width < 600
            ? math.min(screenSize.width * 0.8, 300.0)
            : 300.0;

    return SizedBox(
      width: boardWidth, // 响应式宽度
      child: AspectRatio(
        aspectRatio: kBoardWidth / kBoardHeight,
        child: Container(
          decoration: TetrisTheme.boardDecoration,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kBoardWidth,
            ),
            itemCount: kBoardWidth * kBoardHeight,
            itemBuilder: (context, index) {
              final row = index ~/ kBoardWidth;
              final col = index % kBoardWidth;

              // 检查是否是当前方块的一部分
              bool isCurrentPiece = false;
              int cellType = 0;

              if (game.currentPiece != null) {
                for (final cell in game.currentPiece!.getCells()) {
                  if (cell[0] == col && cell[1] == row) {
                    isCurrentPiece = true;
                    cellType = game.currentPiece!.type;
                    break;
                  }
                }
              }

              // 如果不是当前方块，检查游戏板上的方块
              if (!isCurrentPiece) {
                cellType = game.board.grid[row][col];
              }

              return _buildCell(cellType);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCell(int cellType) {
    // 使用主题中定义的单元格样式
    if (cellType > 0) {
      final color = kPieceColors[cellType]!;
      return Container(
        margin: const EdgeInsets.all(1.0),
        decoration: TetrisTheme.cellDecoration(color),
      );
    } else {
      // 空单元格显示网格线
      return Container(
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: TetrisTheme.primaryColor.withAlpha(26), // 0.1 透明度
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
      );
    }
  }
}
