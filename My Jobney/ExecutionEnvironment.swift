//
//  ExecutionEnvironment.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/20/23.
//

import Foundation

/// An environment the applications runs in - production, previews, or test.
///
/// Useful for dependency management and checking for some feature availability.
enum ExecutionEnvironment {
    
    /// The production environment - the application is running on a user's device.
    case production
    /// The application is running in a Canvas preview.
    case preview
    /// The application is being tested.
    case test
    
    /// Environment the application is currently running in.
    static var current: Self {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return .test
        }
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
            return .preview
        }
        return .production
    }
}
