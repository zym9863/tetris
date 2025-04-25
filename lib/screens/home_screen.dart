import 'package:flutter/material.dart';
import 'game_screen.dart';
import '../utils/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: TetrisTheme.backgroundDecoration,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 游戏标题
              const Text('俄罗斯方块', style: TetrisTheme.titleStyle),
              const SizedBox(height: 60.0),
              // 开始游戏按钮
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                style: TetrisTheme.primaryButtonStyle,
                icon: const Icon(Icons.play_arrow, size: 28.0),
                label: const Text(
                  '开始游戏',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
              // 游戏说明按钮
              ElevatedButton.icon(
                onPressed: () {
                  _showInstructions(context);
                },
                style: TetrisTheme.secondaryButtonStyle,
                icon: const Icon(Icons.info_outline, size: 28.0),
                label: const Text(
                  '游戏说明',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: TetrisTheme.surfaceColor,
            title: Text('游戏说明', style: TetrisTheme.subtitleStyle),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(
                color: TetrisTheme.secondaryColor.withOpacity(0.5),
                width: 2.0,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '操作说明：',
                    style: TetrisTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: TetrisTheme.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildInstructionItem(Icons.keyboard_arrow_left, '左箭头：向左移动'),
                  _buildInstructionItem(Icons.keyboard_arrow_right, '右箭头：向右移动'),
                  _buildInstructionItem(Icons.keyboard_arrow_down, '下箭头：向下移动'),
                  _buildInstructionItem(Icons.keyboard_arrow_up, '上箭头：旋转方块'),
                  _buildInstructionItem(Icons.space_bar, '空格键：快速下落'),
                  _buildInstructionItem(Icons.pause, 'P键：暂停/继续'),
                  _buildInstructionItem(Icons.refresh, 'R键：重新开始'),
                  const SizedBox(height: 16.0),
                  Text(
                    '游戏规则：',
                    style: TetrisTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: TetrisTheme.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildInstructionItem(Icons.arrow_downward, '方块会从顶部落下'),
                  _buildInstructionItem(Icons.swap_horiz, '移动和旋转方块使其填满一行'),
                  _buildInstructionItem(Icons.clear_all, '填满的行会被消除，并获得分数'),
                  _buildInstructionItem(Icons.speed, '随着等级提高，方块下落速度会加快'),
                  _buildInstructionItem(Icons.warning_amber, '当方块堆到顶部时，游戏结束'),
                ],
              ),
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                style: TetrisTheme.secondaryButtonStyle,
                icon: const Icon(Icons.check),
                label: const Text('了解'),
              ),
            ],
          ),
    );
  }

  Widget _buildInstructionItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: TetrisTheme.accentColor, size: 20.0),
          const SizedBox(width: 8.0),
          Expanded(child: Text(text, style: TetrisTheme.bodyStyle)),
        ],
      ),
    );
  }
}
