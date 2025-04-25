import 'dart:async';
import 'dart:math';

import 'board.dart';
import 'piece.dart';
import '../utils/constants.dart';

enum GameState { playing, paused, gameOver }

class TetrisGame {
  Board board;
  Piece? currentPiece;
  Piece? nextPiece;
  GameState state;
  int score;
  int level;
  int linesCleared;
  int gameSpeed;
  Timer? _timer;

  // 游戏状态变化回调
  final Function() onGameStateChanged;

  TetrisGame({required this.onGameStateChanged})
    : board = Board(),
      state = GameState.gameOver,
      score = 0,
      level = 1,
      linesCleared = 0,
      gameSpeed = kInitialSpeed;

  // 开始新游戏
  void newGame() {
    board.reset();
    currentPiece = Piece.random();
    nextPiece = Piece.random();
    state = GameState.playing;
    score = 0;
    level = 1;
    linesCleared = 0;
    gameSpeed = kInitialSpeed;

    _startTimer();
    onGameStateChanged();
  }

  // 暂停/继续游戏
  void togglePause() {
    if (state == GameState.playing) {
      state = GameState.paused;
      _stopTimer();
    } else if (state == GameState.paused) {
      state = GameState.playing;
      _startTimer();
    }
    onGameStateChanged();
  }

  // 游戏主循环
  void _gameLoop() {
    if (state != GameState.playing) return;

    try {
      if (currentPiece == null) {
        _spawnNewPiece();
        return;
      }

      // 尝试下移当前方块
      final movedPiece = currentPiece!.copy();
      movedPiece.move(0, 1);

      if (board.isValidPosition(movedPiece)) {
        // 可以下移
        currentPiece = movedPiece;
        onGameStateChanged();
      } else {
        // 不能下移，固定方块
        board.placePiece(currentPiece!);

        // 检查并清除已满的行
        final clearedLines = board.clearLines();
        if (clearedLines > 0) {
          _updateScore(clearedLines);
        }

        // 检查游戏是否结束
        if (board.isGameOver()) {
          _gameOver();
          return;
        }

        // 生成新方块
        _spawnNewPiece();
      }
    } catch (e) {
      // 捕获可能的异常，防止游戏崩溃
      // 如果发生错误，尝试恢复游戏状态
      if (state != GameState.gameOver) {
        // 如果游戏没有结束，尝试重置游戏状态
        if (currentPiece == null) {
          _spawnNewPiece();
        }
      }
    }
  }

  // 生成新方块
  void _spawnNewPiece() {
    // 确保nextPiece不为null
    nextPiece ??= Piece.random();

    currentPiece = nextPiece;
    nextPiece = Piece.random();

    // 检查新方块是否可以放置
    if (currentPiece != null && !board.isValidPosition(currentPiece!)) {
      _gameOver();
    }

    onGameStateChanged();
  }

  // 更新分数
  void _updateScore(int clearedLines) {
    // 计算得分
    score += clearedLines * kPointsPerLine * level;
    linesCleared += clearedLines;

    // 更新等级
    final newLevel = (linesCleared ~/ 10) + 1;
    if (newLevel > level) {
      level = newLevel;
      _updateSpeed();
    }

    onGameStateChanged();
  }

  // 更新游戏速度
  void _updateSpeed() {
    gameSpeed = max(
      kMinimumSpeed,
      kInitialSpeed - (level - 1) * kSpeedUpFactor,
    );
    _restartTimer();
  }

  // 游戏结束
  void _gameOver() {
    state = GameState.gameOver;
    _stopTimer();
    onGameStateChanged();
  }

  // 启动定时器
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: gameSpeed),
      (_) => _gameLoop(),
    );
  }

  // 停止定时器
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // 重启定时器
  void _restartTimer() {
    _stopTimer();
    _startTimer();
  }

  // 移动方块
  bool movePiece(int deltaX, int deltaY) {
    if (state != GameState.playing || currentPiece == null) return false;

    final movedPiece = currentPiece!.copy();
    movedPiece.move(deltaX, deltaY);

    if (board.isValidPosition(movedPiece)) {
      currentPiece = movedPiece;
      onGameStateChanged();
      return true;
    }

    return false;
  }

  // 旋转方块
  bool rotatePiece() {
    if (state != GameState.playing || currentPiece == null) return false;

    final rotatedPiece = currentPiece!.copy();
    rotatedPiece.rotate(true);

    if (board.isValidPosition(rotatedPiece)) {
      currentPiece = rotatedPiece;
      onGameStateChanged();
      return true;
    }

    // 尝试墙踢（wall kick）：如果旋转后与墙壁重叠，尝试左右移动一格
    for (final offset in [
      [-1, 0],
      [1, 0],
      [-2, 0],
      [2, 0],
    ]) {
      final kickedPiece = rotatedPiece.copy();
      kickedPiece.move(offset[0], offset[1]);

      if (board.isValidPosition(kickedPiece)) {
        currentPiece = kickedPiece;
        onGameStateChanged();
        return true;
      }
    }

    return false;
  }

  // 快速下落
  void hardDrop() {
    // 检查游戏状态和当前方块
    if (state != GameState.playing || currentPiece == null) return;

    try {
      // 持续下移直到不能移动
      while (movePiece(0, 1)) {
        // 空循环，只是为了下移方块
      }

      // 确保游戏状态仍然是playing，防止在下落过程中游戏状态改变
      if (state == GameState.playing && currentPiece != null) {
        // 触发一次游戏循环，固定方块
        _gameLoop();
      }
    } catch (e) {
      // 捕获可能的异常，防止游戏崩溃
      // 如果发生错误，尝试恢复游戏状态
      if (state != GameState.gameOver) {
        // 如果游戏没有结束，尝试生成新方块
        if (currentPiece == null) {
          _spawnNewPiece();
        }
      }
    }
  }

  // 释放资源
  void dispose() {
    _stopTimer();
  }
}
