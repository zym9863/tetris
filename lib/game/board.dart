import '../utils/constants.dart';
import 'piece.dart';

class Board {
  // 游戏板状态，0表示空，非0表示有方块，值对应方块类型
  List<List<int>> grid;
  
  Board() : grid = List.generate(
    kBoardHeight, 
    (_) => List.filled(kBoardWidth, 0)
  );
  
  // 重置游戏板
  void reset() {
    for (int row = 0; row < kBoardHeight; row++) {
      for (int col = 0; col < kBoardWidth; col++) {
        grid[row][col] = 0;
      }
    }
  }
  
  // 检查是否可以放置方块
  bool isValidPosition(Piece piece) {
    for (final cell in piece.getCells()) {
      final col = cell[0];
      final row = cell[1];
      
      // 检查是否超出边界
      if (col < 0 || col >= kBoardWidth || row < 0 || row >= kBoardHeight) {
        return false;
      }
      
      // 检查是否与已有方块重叠
      if (row >= 0 && grid[row][col] != 0) {
        return false;
      }
    }
    
    return true;
  }
  
  // 将方块固定到游戏板上
  void placePiece(Piece piece) {
    for (final cell in piece.getCells()) {
      final col = cell[0];
      final row = cell[1];
      
      if (row >= 0 && row < kBoardHeight && col >= 0 && col < kBoardWidth) {
        grid[row][col] = piece.type;
      }
    }
  }
  
  // 检查并清除已满的行，返回清除的行数
  int clearLines() {
    int linesCleared = 0;
    
    for (int row = kBoardHeight - 1; row >= 0; row--) {
      if (_isRowFull(row)) {
        _clearRow(row);
        linesCleared++;
      }
    }
    
    return linesCleared;
  }
  
  // 检查一行是否已满
  bool _isRowFull(int row) {
    for (int col = 0; col < kBoardWidth; col++) {
      if (grid[row][col] == 0) {
        return false;
      }
    }
    return true;
  }
  
  // 清除一行并将上方的行下移
  void _clearRow(int rowToClear) {
    for (int row = rowToClear; row > 0; row--) {
      for (int col = 0; col < kBoardWidth; col++) {
        grid[row][col] = grid[row - 1][col];
      }
    }
    
    // 清空最顶行
    for (int col = 0; col < kBoardWidth; col++) {
      grid[0][col] = 0;
    }
  }
  
  // 检查游戏是否结束（顶部有方块）
  bool isGameOver() {
    for (int col = 0; col < kBoardWidth; col++) {
      if (grid[0][col] != 0) {
        return true;
      }
    }
    return false;
  }
}
