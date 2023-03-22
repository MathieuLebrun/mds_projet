import 'package:flame/components.dart';

class DinoWorld extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite("background2.png");
    size = Vector2(12183, 850);

    /*Vector2(8500, 850);
    print(4289.0,299.0);
    Vector2(4289, 850);*/
    print(sprite!.originalSize);
  }
}
