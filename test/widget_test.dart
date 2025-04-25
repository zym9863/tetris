// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:tetris/main.dart';
import 'package:tetris/screens/home_screen.dart';

void main() {
  testWidgets('App should render home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the home screen is rendered.
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('俄罗斯方块'), findsOneWidget);
    expect(find.text('开始游戏'), findsOneWidget);
  });
}
