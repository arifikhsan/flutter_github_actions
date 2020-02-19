import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('counter app', () {
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('starts at 0', () async {
      expect(await driver.getText(counterTextFinder), '0');
    });

    test('increments the counter', () async {
      await driver.tap(buttonFinder);
      expect(await driver.getText(counterTextFinder), '1');
    });
  });
}
