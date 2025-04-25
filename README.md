# 俄罗斯方块 (Tetris)

[简体中文](README.md) | [English](README_EN.md)

一个使用 Flutter 开发的现代化俄罗斯方块游戏，具有流畅的游戏体验和精美的界面设计。

## 功能特点

- 经典的俄罗斯方块游戏玩法
- 现代化的界面设计和动画效果
- 支持触摸控制和键盘操作
- 分数统计和等级系统
- 游戏暂停和继续功能
- 下一个方块预览
- 随着等级提高，游戏难度逐渐增加

## 安装与运行

### 前提条件

- Flutter SDK (最新版本)
- Android Studio 或 VS Code
- Android 或 iOS 设备/模拟器

### 安装步骤

1. 克隆仓库
   ```
   git clone https://github.com/zym9863/tetris.git
   ```

2. 进入项目目录
   ```
   cd tetris
   ```

3. 获取依赖
   ```
   flutter pub get
   ```

4. 运行应用
   ```
   flutter run
   ```

## 游戏控制

### 触摸控制
- 左/右按钮：左右移动方块
- 下按钮：加速下落
- 旋转按钮：旋转方块
- 快速下落按钮：立即下落到底部

### 键盘控制
- 左/右箭头：左右移动方块
- 下箭头：加速下落
- 上箭头：旋转方块
- 空格键：快速下落
- P键：暂停/继续游戏
- R键：重新开始游戏

## 游戏规则

- 方块从顶部落下，玩家可以移动和旋转方块
- 当一行被方块填满时，该行会被消除，并获得分数
- 随着等级提高，方块下落速度会加快
- 当方块堆到顶部时，游戏结束

## 技术实现

本项目使用 Flutter 框架开发，主要包含以下模块：

- `lib/game/`: 游戏核心逻辑
  - `tetris_game.dart`: 游戏主控制器
  - `board.dart`: 游戏板逻辑
  - `piece.dart`: 方块定义和操作

- `lib/screens/`: 游戏界面
  - `home_screen.dart`: 主菜单界面
  - `game_screen.dart`: 游戏主界面

- `lib/widgets/`: UI组件
  - `board_widget.dart`: 游戏板显示
  - `next_piece_widget.dart`: 下一个方块预览
  - `score_widget.dart`: 分数显示

- `lib/utils/`: 工具类
  - `constants.dart`: 游戏常量定义
  - `theme.dart`: 游戏主题和样式

## 贡献

欢迎提交 Pull Request 或创建 Issue 来改进这个项目。

## 许可证

本项目采用 MIT 许可证 - 详情请查看 [LICENSE](LICENSE) 文件。
