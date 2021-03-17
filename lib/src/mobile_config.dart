part of katana_mobile;

/// Class that manages the configuration of Masamune framework for mobile.
///
/// Initial values are set but can be changed at any time.
class MobileConfig {
  MobileConfig._();

  /// True if the config has been initialized.
  static bool get isInitialized => _isInitialized;
  static bool _isInitialized = false;

  /// Initialize the configuration.
  static Future initialize() async {
    if (kIsWeb) {
      _isInitialized = true;
      return;
    }
    final deviceInfoPlugin = DeviceInfoPlugin();
    await Future.wait([
      getTemporaryDirectory().then((value) => _temporaryDirectory = value),
      getApplicationDocumentsDirectory()
          .then((value) => _documentDirectory = value),
      PackageInfo.fromPlatform().then((value) => _packageInfo = value),
      if (Config.isIOS) ...[
        getLibraryDirectory().then((value) => _libraryDirectory = value),
        deviceInfoPlugin.iosInfo.then((value) => _iosDeviceInfo = value),
      ],
      if (Config.isAndroid) ...[
        getExternalStorageDirectory().then((value) async {
          if (value == null) {
            _libraryDirectory = await getApplicationDocumentsDirectory();
          } else {
            _libraryDirectory = value;
          }
        }),
        deviceInfoPlugin.androidInfo
            .then((value) => _androidDeviceInfo = value),
      ]
    ]);
    _isInitialized = true;
  }

  /// IOS device information.
  static IosDeviceInfo get isoDeviceInfo => _iosDeviceInfo;
  static late final IosDeviceInfo _iosDeviceInfo;

  /// Android device information.
  static AndroidDeviceInfo get androidDeviceInfo => _androidDeviceInfo;
  static late final AndroidDeviceInfo _androidDeviceInfo;

  /// Package information.
  static PackageInfo get packageInfo => _packageInfo;
  static late final PackageInfo _packageInfo;

  /// The directory that stores temporary files.
  static Directory get temporaryDirectory => _temporaryDirectory;
  static late Directory _temporaryDirectory;

  /// The directory where you want to save the document file.
  static Directory get documentDirectory => _documentDirectory;
  static late Directory _documentDirectory;

  /// The directory where you want to save the library file.
  static Directory get libraryDirectory => _libraryDirectory;
  static late Directory _libraryDirectory;
}
