import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('counter app', () {
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      Directory('screenshots').create();

    });

    takeScreenshot(FlutterDriver driver, String path) async {
      final List<int> pixels = await driver.screenshot();
      final File file = File(path);
      await file.writeAsBytes(pixels);
      print('path');
    }

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
      await takeScreenshot(driver, 'screenshots/initial.png');
    });

    test('increments the counter', () async {
      await driver.tap(buttonFinder);
      expect(await driver.getText(counterTextFinder), '1');
      await takeScreenshot(driver, 'screenshots/increment.png');
    });
  });
}
