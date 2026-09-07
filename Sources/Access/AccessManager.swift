import Foundation

/// Manages device access control and permissions
public class AccessManager {
    public enum PermissionType {
        case camera
        case microphone
        case contacts
        case calendar
        case photos
        case location
        case healthData
        case siri
        case bluetooth
        case homeKit
        case mediaLibrary
        case fileAccess
    }
    
    public enum PermissionStatus {
        case granted
        case denied
        case restricted
        case notDetermined
    }
    
    public struct PermissionInfo {
        public let type: PermissionType
        public let status: PermissionStatus
        public let appName: String
        public let grantedAt: Date?
        public let expiresAt: Date?
        
        init(type: PermissionType, status: PermissionStatus, appName: String) {
            self.type = type
            self.status = status
            self.appName = appName
            self.grantedAt = status == .granted ? Date() : nil
            self.expiresAt = nil
        }
    }
    
    public struct AccessSession {
        public let id: String
        public let userId: String
        public let deviceId: String
        public let loginTime: Date
        public let lastActivity: Date
        public let permissions: [PermissionInfo]
        public let ipAddress: String?
        public let location: String?
        
        init(userId: String, deviceId: String, permissions: [PermissionInfo]) {
            self.id = UUID().uuidString
            self.userId = userId
            self.deviceId = deviceId
            self.loginTime = Date()
            self.lastActivity = Date()
            self.permissions = permissions
            self.ipAddress = nil
            self.location = nil
        }
    }
    
    private var activeSessions: [AccessSession] = []
    private var permissionLog: [PermissionInfo] = []
    
    func initialize() {
        print("[Access] Manager initialized")
    }
    
    /// Request permission for an app
    public func requestPermission(_ type: PermissionType, for appName: String) -> PermissionInfo {
        let permission = PermissionInfo(type: type, status: .notDetermined, appName: appName)
        permissionLog.append(permission)
        print("[Access] Permission requested: \(type) for \(appName)")
        return permission
    }
    
    /// Grant permission
    public func grantPermission(_ type: PermissionType, for appName: String) -> PermissionInfo {
        let permission = PermissionInfo(type: type, status: .granted, appName: appName)
        permissionLog.append(permission)
        print("[Access] Permission granted: \(type) for \(appName)")
        return permission
    }
    
    /// Revoke permission
    public func revokePermission(_ type: PermissionType, for appName: String) -> PermissionInfo {
        let permission = PermissionInfo(type: type, status: .denied, appName: appName)
        permissionLog.append(permission)
        print("[Access] Permission revoked: \(type) for \(appName)")
        return permission
    }
    
    /// Create an access session
    public func createAccessSession(userId: String, deviceId: String, permissions: [PermissionInfo]) -> AccessSession {
        let session = AccessSession(userId: userId, deviceId: deviceId, permissions: permissions)
        activeSessions.append(session)
        print("[Access] Session created for user: \(userId)")
        return session
    }
    
    /// Revoke access session
    public func revokeAccessSession(sessionId: String) -> Bool {
        if let index = activeSessions.firstIndex(where: { $0.id == sessionId }) {
            activeSessions.remove(at: index)
            print("[Access] Session revoked: \(sessionId)")
            return true
        }
        return false
    }
    
    /// Get all active sessions
    public func getActiveSessions() -> [AccessSession] {
        return activeSessions
    }
    
    /// Get permission log
    public func getPermissionLog() -> [PermissionInfo] {
        return permissionLog
    }
    
    /// Check if app has permission
    public func hasPermission(_ type: PermissionType, for appName: String) -> Bool {
        return permissionLog.contains { $0.type == type && $0.appName == appName && $0.status == .granted }
    }
    
    /// Revoke all permissions for an app
    public func revokeAllPermissionsForApp(_ appName: String) {
        permissionLog = permissionLog.filter { $0.appName != appName }
        print("[Access] All permissions revoked for app: \(appName)")
    }
    
    /// Clear all sessions
    public func clearAllSessions() {
        activeSessions.removeAll()
        print("[Access] All sessions cleared")
    }
}
