class AppConstants {
  AppConstants._();

  // Database
  static const String dbFileName = 'stock_note.db';
  static const int dbVersion = 1;

  // Google Drive
  static const String driveDbFileName = 'stock_note.db';
  static const String driveLockFileName = 'stock_note.lock';
  static const String driveAppDataFolder = 'appDataFolder';
  static const List<String> driveScopes = [
    'https://www.googleapis.com/auth/drive.appdata',
  ];

  // Sync
  static const int maxSyncRetries = 3;
  static const int lockExpiryHours = 24;

  // UI
  static const int dashboardRecentCount = 20;
  static const int dashboardDays = 7;
  static const int memoMaxLength = 2000;
}
