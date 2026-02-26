import 'package:hive_flutter/hive_flutter.dart';

/// A centralized service for reading and writing persistent app preferences
/// using Hive — a lightweight, fast, NoSQL key-value database for Flutter.
///
/// Usage:
///   1. Call [HiveService.init()] once in `main()` before `runApp()`.
///   2. Use [HiveService.isFirstTime] to check if onboarding should be shown.
///   3. Call [HiveService.completeOnboarding()] when the user finishes onboarding.
class HiveService {
  // ── Constants ──────────────────────────────────────────────────────────────

  /// The name of the Hive box (think of it as a storage file/table).
  static const String _boxName = 'appBox';

  /// The key used to store the first-launch flag inside the box.
  static const String _isFirstTimeKey = 'isFirstTime';

  // ── Internal state ─────────────────────────────────────────────────────────

  /// Private reference to the opened box. Set by [init()].
  static Box? _box;

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Initializes Hive and opens the app's storage box.
  ///
  /// This MUST be called before any read/write operations.
  /// Call it once inside `main()`, after `WidgetsFlutterBinding.ensureInitialized()`.
  static Future<void> init() async {
    // Sets up Hive to use the correct file path on the device.
    await Hive.initFlutter();

    // Opens (or creates) the box named 'appBox'.
    // If the box already exists on disk, it loads the saved data into memory.
    _box = await Hive.openBox(_boxName);
  }

  /// Returns `true` if this is the **first time** the app launches.
  ///
  /// Defaults to `true` when the key hasn't been set yet (i.e., fresh install).
  /// Returns `false` after [completeOnboarding()] has been called.
  static bool get isFirstTime =>
      _openBox.get(_isFirstTimeKey, defaultValue: true) as bool;

  /// Marks onboarding as completed by writing `false` to local storage.
  ///
  /// After this is called, [isFirstTime] will return `false` permanently —
  /// even after the app is closed and reopened — until the app is uninstalled.
  static Future<void> completeOnboarding() async {
    await _openBox.put(_isFirstTimeKey, false);
  }

  // ── Private helper ─────────────────────────────────────────────────────────

  /// Safety check: ensures [init()] was called before the box is accessed.
  static Box get _openBox {
    assert(_box != null, 'HiveService.init() must be called before use.');
    return _box!;
  }
}
