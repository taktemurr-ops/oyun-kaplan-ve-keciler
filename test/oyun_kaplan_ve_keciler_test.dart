import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_kaplan_ve_keciler/oyun_kaplan_ve_keciler.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(kaplanKeciConfig.title.length, 33);
    expect(kaplanKeciConfig.tagline.length, 33);
    for (final s in kaplanKeciConfig.tutorial) {
      expect(s.text.length, 33);
    }
    expect(kaplanKeciConfig.gameId, kaplanKeciId);
    expect(kaplanKeciRules.gameId, kaplanKeciId);
    expect(kaplanKeciRules.levelCount, 100000);
  });

  test('bölümler üretilir ve doğrulanır', () {
    expect(kaplanKeciRules.localPlayers, 2);
    final planner = LevelPlanner(gameId: kaplanKeciId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = kaplanKeciRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final back = gl.puzzle.rules.parse(gl.puzzle.start.serialize());
      expect(back.serialize(), gl.puzzle.start.serialize());
    }
  }, timeout: const Timeout(Duration(minutes: 8)));
}
