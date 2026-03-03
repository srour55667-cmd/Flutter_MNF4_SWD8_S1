import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _boxName = 'appBox';

  static const String _isFirstTimeKey = 'isFirstTime';

  static Box? _box;

  static Future<void> init() async {
    await Hive.initFlutter();

    _box = await Hive.openBox(_boxName);
  }

  static bool get isFirstTime =>
      _openBox.get(_isFirstTimeKey, defaultValue: true) as bool;

  static Future<void> completeOnboarding() async {
    await _openBox.put(_isFirstTimeKey, false);
  }

  static Box get _openBox {
    assert(_box != null, 'HiveService.init() must be called before use.');
    return _box!;
  }
}
