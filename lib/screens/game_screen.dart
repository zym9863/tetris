import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/tetris_game.dart';
import '../utils/theme.dart';
import '../widgets/board_widget.dart';
import '../widgets/next_piece_widget.dart';
import '../widgets/score_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TetrisGame _game;

  @override
  void initState() {
    super.initState();
    _game = TetrisGame(onGameStateChanged: _onGameStateChanged);
    _game.newGame();
  }

  @override
  void dispose() {
    _game.dispose();
    super.dispose();
  }

  void _onGameStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Container(
        decoration: TetrisTheme.backgroundDecoration,
        child: SafeArea(
          child: Column(
            children: [
              // 自定义AppBar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text('俄罗斯方块', style: TetrisTheme.subtitleStyle),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _game.state == GameState.paused
                                ? Icons.play_arrow
                                : Icons.pause,
                            color: TetrisTheme.secondaryColor,
                          ),
                          onPressed:
                              _game.state != GameState.gameOver
                                  ? _game.togglePause
                                  : null,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: TetrisTheme.secondaryColor,
                          ),
                          onPressed: _game.newGame,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 游戏主体内容
              Expanded(
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  autofocus: true,
                  onKeyEvent: _handleKeyEvent,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_game.state == GameState.gameOver)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              margin: const EdgeInsets.only(bottom: 20.0),
                              decoration: BoxDecoration(
                                color: TetrisTheme.accentColor.withAlpha(
                                  204,
                                ), // 0.8 透明度
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: TetrisTheme.accentColor.withAlpha(
                                      128,
                                    ), // 0.5 透明度
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Text(
                                '游戏结束',
                                style: TetrisTheme.subtitleStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                          // 根据屏幕宽度选择布局方式
                          if (isSmallScreen)
                            _buildVerticalLayout(screenSize)
                          else
                            _buildHorizontalLayout(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 垂直布局 - 适用于窄屏设备（如手机）
  Widget _buildVerticalLayout(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 游戏板
        BoardWidget(game: _game),
        const SizedBox(height: 16.0),
        // 信息和控制区域
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [NextPieceWidget(game: _game), ScoreWidget(game: _game)],
          ),
        ),
        const SizedBox(height: 16.0),
        // 控制按钮
        _buildControlButtons(),
      ],
    );
  }

  // 水平布局 - 适用于宽屏设备（如平板、桌面）
  Widget _buildHorizontalLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoardWidget(game: _game),
        const SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NextPieceWidget(game: _game),
            const SizedBox(height: 20.0),
            ScoreWidget(game: _game),
            const SizedBox(height: 20.0),
            _buildControlButtons(),
          ],
        ),
      ],
    );
  }

  Widget _buildControlButtons() {
    // 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    // 根据屏幕大小调整控制按钮的尺寸
    final buttonSize = isSmallScreen ? 48.0 : 56.0;
    final iconSize = isSmallScreen ? 24.0 : 28.0;

    return Container(
      width: isSmallScreen ? screenSize.width * 0.9 : 180,
      padding: const EdgeInsets.all(12.0),
      decoration: TetrisTheme.containerDecoration,
      child: Column(
        children: [
          // 旋转按钮
          Container(
            decoration: BoxDecoration(
              color: TetrisTheme.primaryColor.withAlpha(153), // 0.6 透明度
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: iconSize,
              icon: const Icon(Icons.rotate_right, color: Colors.white),
              onPressed:
                  _game.state == GameState.playing ? _game.rotatePiece : null,
            ),
          ),
          const SizedBox(height: 8.0),
          // 方向按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDirectionButton(
                Icons.arrow_left,
                () => _game.movePiece(-1, 0),
                buttonSize,
                iconSize,
              ),
              _buildDirectionButton(
                Icons.arrow_downward,
                () => _game.movePiece(0, 1),
                buttonSize,
                iconSize,
              ),
              _buildDirectionButton(
                Icons.arrow_right,
                () => _game.movePiece(1, 0),
                buttonSize,
                iconSize,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // 快速下落按钮
          Container(
            decoration: BoxDecoration(
              color: TetrisTheme.accentColor.withAlpha(153), // 0.6 透明度
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              iconSize: iconSize,
              icon: const Icon(
                Icons.vertical_align_bottom,
                color: Colors.white,
              ),
              onPressed:
                  _game.state == GameState.playing ? _game.hardDrop : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionButton(
    IconData icon,
    VoidCallback onPressed, [
    double buttonSize = 48.0,
    double iconSize = 24.0,
  ]) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: TetrisTheme.secondaryColor.withAlpha(153), // 0.6 透明度
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: iconSize,
        icon: Icon(icon, color: Colors.white),
        onPressed: _game.state == GameState.playing ? onPressed : null,
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          _game.movePiece(-1, 0);
          break;
        case LogicalKeyboardKey.arrowRight:
          _game.movePiece(1, 0);
          break;
        case LogicalKeyboardKey.arrowDown:
          _game.movePiece(0, 1);
          break;
        case LogicalKeyboardKey.arrowUp:
          _game.rotatePiece();
          break;
        case LogicalKeyboardKey.space:
          _game.hardDrop();
          break;
        case LogicalKeyboardKey.keyP:
          if (_game.state != GameState.gameOver) {
            _game.togglePause();
          }
          break;
        case LogicalKeyboardKey.keyR:
          _game.newGame();
          break;
        default:
          break;
      }
    }
  }
}
