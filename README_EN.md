# Tetris

[简体中文](README.md) | [English](README_EN.md)

A modern Tetris game developed with Flutter, featuring smooth gameplay and beautiful interface design.

## Features

- Classic Tetris gameplay
- Modern interface design and animations
- Support for touch controls and keyboard operations
- Score statistics and level system
- Game pause and resume functionality
- Next block preview
- Gradually increasing difficulty as levels progress

## Installation and Running

### Prerequisites

- Flutter SDK (latest version)
- Android Studio or VS Code
- Android or iOS device/emulator

### Installation Steps

1. Clone the repository
   ```
   git clone https://github.com/zym9863/tetris.git
   ```

2. Enter the project directory
   ```
   cd tetris
   ```

3. Get dependencies
   ```
   flutter pub get
   ```

4. Run the application
   ```
   flutter run
   ```

## Game Controls

### Touch Controls
- Left/Right buttons: Move block left/right
- Down button: Accelerate falling
- Rotate button: Rotate block
- Quick drop button: Immediately drop to the bottom

### Keyboard Controls
- Left/Right arrows: Move block left/right
- Down arrow: Accelerate falling
- Up arrow: Rotate block
- Space key: Quick drop
- P key: Pause/Resume game
- R key: Restart game

## Game Rules

- Blocks fall from the top, players can move and rotate blocks
- When a row is filled with blocks, that row is cleared and points are earned
- As levels increase, blocks fall faster
- Game ends when blocks stack to the top

## Technical Implementation

This project is developed using the Flutter framework and mainly includes the following modules:

- `lib/game/`: Game core logic
  - `tetris_game.dart`: Main game controller
  - `board.dart`: Game board logic
  - `piece.dart`: Block definitions and operations

- `lib/screens/`: Game interfaces
  - `home_screen.dart`: Main menu interface
  - `game_screen.dart`: Main game interface

- `lib/widgets/`: UI components
  - `board_widget.dart`: Game board display
  - `next_piece_widget.dart`: Next block preview
  - `score_widget.dart`: Score display

- `lib/utils/`: Utility classes
  - `constants.dart`: Game constant definitions
  - `theme.dart`: Game themes and styles

## Contribution

Pull Requests and Issues are welcome to improve this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
