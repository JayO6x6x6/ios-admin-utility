import Foundation

/// Manages development tools and debugging utilities
public class DevelopmentToolsManager {
    public enum DebugLevel {
        case verbose
        case debug
        case info
        case warning
        case error
    }
    
    public struct DeviceInfo {
        public let deviceModel: String
        public let osVersion: String
        public let bundleIdentifier: String
        public let appVersion: String
        public let buildNumber: String
        public let isSimulator: Bool
        public let processorType: String
        public let memorySize: UInt64
        
        init() {
            self.deviceModel = UIDevice.current.model
            self.osVersion = UIDevice.current.systemVersion
            self.bundleIdentifier = Bundle.main.bundleIdentifier ?? "Unknown"
            self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
            self.buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
            
            #if targetEnvironment(simulator)
            self.isSimulator = true
            #else
            self.isSimulator = false
            #endif
            
            self.processorType = ProcessInfo.processInfo.processorCount > 4 ? "Multi-core" : "Dual-core"
            self.memorySize = ProcessInfo.processInfo.physicalMemory
        }
    }
    
    public struct DebugLog {
        public let timestamp: Date
        public let level: DebugLevel
        public let category: String
        public let message: String
        public let stackTrace: String?
        
        init(level: DebugLevel, category: String, message: String, stackTrace: String? = nil) {
            self.timestamp = Date()
            self.level = level
            self.category = category
            self.message = message
            self.stackTrace = stackTrace
        }
    }
    
    private var debugLogs: [DebugLog] = []
    private var currentDebugLevel: DebugLevel = .debug
    public let deviceInfo: DeviceInfo
    
    init() {
        self.deviceInfo = DeviceInfo()
    }
    
    func initialize() {
        print("[Development] Manager initialized")
        print("[Development] Device: \(deviceInfo.deviceModel) - \(deviceInfo.osVersion)")
        print("[Development] App: \(deviceInfo.bundleIdentifier) v\(deviceInfo.appVersion)")
    }
    
    /// Set debug level
    public func setDebugLevel(_ level: DebugLevel) {
        currentDebugLevel = level
        print("[Development] Debug level set to: \(level)")
    }
    
    /// Log debug message
    public func logDebug(_ category: String, _ message: String) {
        let log = DebugLog(level: .debug, category: category, message: message)
        if shouldLog(.debug) {
            debugLogs.append(log)
            print("[\(category)] DEBUG: \(message)")
        }
    }
    
    /// Log info message
    public func logInfo(_ category: String, _ message: String) {
        let log = DebugLog(level: .info, category: category, message: message)
        if shouldLog(.info) {
            debugLogs.append(log)
            print("[\(category)] INFO: \(message)")
        }
    }
    
    /// Log warning message
    public func logWarning(_ category: String, _ message: String) {
        let log = DebugLog(level: .warning, category: category, message: message)
        if shouldLog(.warning) {
            debugLogs.append(log)
            print("[\(category)] WARNING: \(message)")
        }
    }
    
    /// Log error message
    public func logError(_ category: String, _ message: String, stackTrace: String? = nil) {
        let log = DebugLog(level: .error, category: category, message: message, stackTrace: stackTrace)
        if shouldLog(.error) {
            debugLogs.append(log)
            print("[\(category)] ERROR: \(message)")
            if let trace = stackTrace {
                print("Stack Trace: \(trace)")
            }
        }
    }
    
    /// Check if should log based on level
    private func shouldLog(_ level: DebugLevel) -> Bool {
        let levels: [DebugLevel] = [.verbose, .debug, .info, .warning, .error]
        guard let currentIndex = levels.firstIndex(of: currentDebugLevel),
              let logIndex = levels.firstIndex(of: level) else {
            return false
        }
        return logIndex >= currentIndex
    }
    
    /// Get all debug logs
    public func getDebugLogs() -> [DebugLog] {
        return debugLogs
    }
    
    /// Get logs for specific category
    public func getLogsForCategory(_ category: String) -> [DebugLog] {
        return debugLogs.filter { $0.category == category }
    }
    
    /// Clear debug logs
    public func clearLogs() {
        debugLogs.removeAll()
        print("[Development] Debug logs cleared")
    }
    
    /// Export logs as JSON
    public func exportLogsAsJSON() -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(debugLogs)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("[Development] Failed to export logs: \(error)")
            return nil
        }
    }
    
    /// Get device information
    public func getDeviceInfo() -> DeviceInfo {
        return deviceInfo
    }
    
    /// Get performance metrics
    public func getPerformanceMetrics() -> [String: Any] {
        let processInfo = ProcessInfo.processInfo
        return [
            "cpuCount": processInfo.processorCount,
            "activeProcessorCount": processInfo.activeProcessorCount,
            "physicalMemory": formatBytes(UInt64(processInfo.physicalMemory)),
            "systemUptime": processInfo.systemUptime,
            "operatingSystemVersion": processInfo.operatingSystemVersion
        ]
    }
    
    /// Format bytes
    private func formatBytes(_ bytes: UInt64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(bytes))
    }
}

import UIKit
