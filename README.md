# iOS Admin Utility

A comprehensive Swift package for iOS device administration, providing tools for troubleshooting, resetting, erasing, access management, and development utilities.

## Features

### 🔍 Troubleshooting Manager
- **System Diagnostics**: Comprehensive device health checks
- **Memory Monitoring**: Track memory usage and detect memory leaks
- **Storage Analysis**: Monitor storage capacity and usage patterns
- **Battery Health**: Check battery level and charging status
- **Network Diagnostics**: Verify network connectivity
- **Permission Auditing**: Inspect system permissions

### 🔄 Reset Manager
- **Soft Reset**: Restart applications
- **Hard Reset**: Complete device restart
- **Network Reset**: Clear WiFi, Bluetooth, and VPN settings
- **Settings Reset**: Restore default device settings
- **Keyboard Dictionary Reset**: Clear learned words

### 🗑️ Erase Manager
- **Cache Cleaning**: Remove app cache files
- **Temp File Cleanup**: Delete temporary files
- **App Data Erasure**: Remove specific app data
- **Selective Data Removal**: Choose what to delete
- **Device Wipe**: Complete device erasure (admin only)

### 🔐 Access Manager
- **Permission Control**: Grant/revoke app permissions
- **Session Management**: Create and monitor access sessions
- **User Access Tracking**: Log all access activities
- **Device Access Restrictions**: Control device access
- **Permission Status Monitoring**: Track permission states

### 🛠️ Development Tools
- **Device Information**: Get detailed device specifications
- **Debug Logging**: Multiple logging levels (verbose, debug, info, warning, error)
- **Performance Metrics**: Monitor CPU, memory, and system resources
- **Log Export**: Export logs in JSON format
- **Simulator Detection**: Identify if running on simulator

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
.package(url: "https://github.com/JayO6x6x6/ios-admin-utility.git", from: "1.0.0")
```

Or in Xcode:
1. File → Add Packages
2. Enter: `https://github.com/JayO6x6x6/ios-admin-utility.git`
3. Select version and add to project

## Quick Start

### Initialize the Admin Utility

```swift
import IOSAdminUtility

let admin = IOSAdminUtility.shared
admin.initialize()
```

### Troubleshooting

```swift
// Run comprehensive diagnostics
let diagnostics = admin.troubleshooter.runDiagnostics()

for report in diagnostics {
    print("Category: \(report.category)")
    print("Status: \(report.status)")
    print("Message: \(report.message)")
}
```

### Reset Operations

```swift
// Perform soft reset
let softReset = admin.resetManager.performSoftReset()
print("Reset Operation: \(softReset.details)")

// Reset network settings
let networkReset = admin.resetManager.resetNetworkSettings()
print("Network Settings: \(networkReset.details)")

// Reset keyboard dictionary
let keyboardReset = admin.resetManager.resetKeyboardDictionary()
```

### Erase Data

```swift
// Clear cache
let cacheErase = admin.eraseManager.eraseCache()
print("Cleared: \(cacheErase.spaceFreed) bytes")

// Erase temporary files
let tempErase = admin.eraseManager.eraseTempFiles()
print("Items deleted: \(tempErase.itemsDeleted)")

// Erase specific app data
let appErase = admin.eraseManager.eraseAppData(bundleIdentifier: "com.example.app")
```

### Access Management

```swift
// Request permission
let permission = admin.accessManager.requestPermission(.camera, for: "MyApp")

// Grant permission
admin.accessManager.grantPermission(.microphone, for: "MyApp")

// Create access session
let session = admin.accessManager.createAccessSession(
    userId: "user123",
    deviceId: "device456",
    permissions: [permission]
)

// Get active sessions
let activeSessions = admin.accessManager.getActiveSessions()

// Revoke session
admin.accessManager.revokeAccessSession(sessionId: session.id)
```

### Development Tools

```swift
// Get device information
let deviceInfo = admin.developmentTools.getDeviceInfo()
print("Device: \(deviceInfo.deviceModel)")
print("OS: \(deviceInfo.osVersion)")
print("Simulator: \(deviceInfo.isSimulator)")

// Set debug level
admin.developmentTools.setDebugLevel(.debug)

// Log messages
admin.developmentTools.logInfo("MyApp", "Application started")
admin.developmentTools.logWarning("MyApp", "Low memory warning")
admin.developmentTools.logError("MyApp", "Critical error occurred")

// Get performance metrics
let metrics = admin.developmentTools.getPerformanceMetrics()
print("CPU Cores: \(metrics["cpuCount"] ?? "Unknown")")
print("Physical Memory: \(metrics["physicalMemory"] ?? "Unknown")")

// Export logs
if let jsonLogs = admin.developmentTools.exportLogsAsJSON() {
    print("Logs exported: \(jsonLogs)")
}
```

## API Reference

### TroubleshootingManager

```swift
func runDiagnostics() -> [DiagnosticReport]
func getDiagnosticsLog() -> [DiagnosticReport]
func clearLogs()
```

### ResetManager

```swift
func performSoftReset() -> ResetOperation
func performHardReset() -> ResetOperation
func resetNetworkSettings() -> ResetOperation
func resetAllSettings() -> ResetOperation
func resetKeyboardDictionary() -> ResetOperation
func getOperationHistory() -> [ResetOperation]
func clearHistory()
```

### EraseManager

```swift
func eraseCache() -> EraseOperation
func eraseTempFiles() -> EraseOperation
func eraseAppData(bundleIdentifier: String) -> EraseOperation
func eraseEntireDevice() -> EraseOperation
func eraseSelectiveData(types: [String]) -> EraseOperation
func getEraseHistory() -> [EraseOperation]
func clearHistory()
```

### AccessManager

```swift
func requestPermission(_ type: PermissionType, for appName: String) -> PermissionInfo
func grantPermission(_ type: PermissionType, for appName: String) -> PermissionInfo
func revokePermission(_ type: PermissionType, for appName: String) -> PermissionInfo
func createAccessSession(userId: String, deviceId: String, permissions: [PermissionInfo]) -> AccessSession
func revokeAccessSession(sessionId: String) -> Bool
func getActiveSessions() -> [AccessSession]
func getPermissionLog() -> [PermissionInfo]
func hasPermission(_ type: PermissionType, for appName: String) -> Bool
func revokeAllPermissionsForApp(_ appName: String)
func clearAllSessions()
```

### DevelopmentToolsManager

```swift
func setDebugLevel(_ level: DebugLevel)
func logDebug(_ category: String, _ message: String)
func logInfo(_ category: String, _ message: String)
func logWarning(_ category: String, _ message: String)
func logError(_ category: String, _ message: String, stackTrace: String?)
func getDebugLogs() -> [DebugLog]
func getLogsForCategory(_ category: String) -> [DebugLog]
func clearLogs()
func exportLogsAsJSON() -> String?
func getDeviceInfo() -> DeviceInfo
func getPerformanceMetrics() -> [String: Any]
```

## Enumerations

### TroubleshootingManager.DiagnosticStatus
- `healthy` - System operating normally
- `warning` - Potential issues detected
- `critical` - Serious issues requiring attention
- `unknown` - Unable to determine status

### ResetManager.ResetType
- `softReset` - Application restart
- `hardReset` - Device restart
- `networkReset` - Network settings reset
- `settingsReset` - All settings reset
- `keyboardDictionary` - Keyboard dictionary reset

### EraseManager.EraseType
- `cacheOnly` - Remove app cache
- `tempFiles` - Remove temporary files
- `appData` - Remove specific app data
- `entireDevice` - Complete device wipe
- `selectiveData` - Remove selected data

### AccessManager.PermissionType
- `camera`
- `microphone`
- `contacts`
- `calendar`
- `photos`
- `location`
- `healthData`
- `siri`
- `bluetooth`
- `homeKit`
- `mediaLibrary`
- `fileAccess`

### DevelopmentToolsManager.DebugLevel
- `verbose` - Most detailed logging
- `debug` - Debug messages
- `info` - General information
- `warning` - Warning messages
- `error` - Error messages only

## Security Considerations

⚠️ **Important**: This utility requires administrator privileges for certain operations:
- Device erase operations
- Access revocation
- System reset operations

**Best Practices**:
1. Always request user confirmation before destructive operations
2. Log all administrative actions
3. Implement proper access controls
4. Regularly audit access logs
5. Use permission systems to restrict functionality

## Requirements

- iOS 14.0+
- Swift 5.5+
- Xcode 13.0+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

---

**Disclaimer**: This utility is for legitimate administrative and development purposes only. Ensure compliance with applicable laws and regulations when using this tool.
