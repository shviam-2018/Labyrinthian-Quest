import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BonfireWidget(
        joystick: Joystick(
          directional: JoystickDirectional(),
        ),
        map: WorldMapByTiled(
          WorldMapReader.fromNetwork( Uri.parse('https://raw.githubusercontent.com/RafaelBarbosatec/rafaelbarbosatec.github.io/master/tiled/my_map.json')), 
          forceTileSize: Vector2(16,16),
          ),
        player: Knight(Vector2(40, 40)),
      ),
    );
  }
}

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/knight_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/knight_run.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class Knight extends SimplePlayer {
  Knight(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(32),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
        );
}