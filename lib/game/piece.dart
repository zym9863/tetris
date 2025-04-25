import 'dart:math';
import '../utils/constants.dart';

class Piece {
  int type; // 方块类型 (1-7)
  int rotation; // 旋转状态 (0-3)
  int x; // 方块左上角的x坐标
  int y; // 方块左上角的y坐标

  Piece({
    required this.type,
    this.rotation = 0,
    required this.x,
    required this.y,
  });

  // 创建随机方块
  factory Piece.random() {
    final random = Random();
    final type = random.nextInt(7) + 1; // 1-7
    
    // 初始位置在顶部中间
    final x = kBoardWidth ~/ 2 - 2;
    const y = 0;
    
    return Piece(type: type, x: x, y: y);
  }

  // 获取当前方块形状
  List<List<int>> get shape => kPieceShapes[type]![rotation];

  // 获取方块宽度
  int get width => shape[0].length;

  // 获取方块高度
  int get height => shape.length;

  // 创建方块副本
  Piece copy() {
    return Piece(
      type: type,
      rotation: rotation,
      x: x,
      y: y,
    );
  }

  // 旋转方块
  void rotate(bool clockwise) {
    if (clockwise) {
      rotation = (rotation + 1) % 4;
    } else {
      rotation = (rotation - 1) % 4;
      if (rotation < 0) rotation += 4;
    }
  }

  // 移动方块
  void move(int deltaX, int deltaY) {
    x += deltaX;
    y += deltaY;
  }

  // 获取方块所有格子的坐标
  List<List<int>> getCells() {
    final cells = <List<int>>[];
    
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if (shape[row][col] != 0) {
          cells.add([x + col, y + row]);
        }
      }
    }
    
    return cells;
  }
}
