import Foundation

/// Main iOS Admin Utility Manager
public class IOSAdminUtility {
    public static let shared = IOSAdminUtility()
    
    public let troubleshooter: TroubleshootingManager
    public let resetManager: ResetManager
    public let eraseManager: EraseManager
    public let accessManager: AccessManager
    public let developmentTools: DevelopmentToolsManager
    
    private init() {
        self.troubleshooter = TroubleshootingManager()
        self.resetManager = ResetManager()
        self.eraseManager = EraseManager()
        self.accessManager = AccessManager()
        self.developmentTools = DevelopmentToolsManager()
    }
    
    /// Initialize all managers and log status
    public func initialize() {
        print("[IOSAdminUtility] Initializing iOS Admin Utility...")
        troubleshooter.initialize()
        resetManager.initialize()
        eraseManager.initialize()
        accessManager.initialize()
        developmentTools.initialize()
        print("[IOSAdminUtility] Initialization complete")
    }
}
