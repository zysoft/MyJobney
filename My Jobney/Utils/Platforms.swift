//
//  Platforms.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/2/24.
//

import Foundation

/// An option set of platforms.
///
/// Has the ``isApplicable`` property allowing to identify if the current platform is in the set.
struct Platforms: OptionSet {
    var rawValue: Int
    
    static let iOS   = Platforms(rawValue: 1 << 0)
    static let macOS = Platforms(rawValue: 1 << 1)
    static let tvOS  = Platforms(rawValue: 1 << 2)
    static let visionOS  = Platforms(rawValue: 1 << 3)
    
    /// `true` if the option set contains the platform the code is running on.
    ///
    /// For example:
    /// ```swift
    /// let set: Platforms = [.iOS, .tvOS]
    /// // Will only output true when running on iOS or tvOS
    /// print(set.isApplicable)
    /// ```
    var isApplicable: Bool {
#if os(iOS)
        self.contains(.iOS)
#elseif os(macOS)
        self.contains(.macOS)
#elseif os(tvOS)
        self.contains(.tvOS)
#elseif os(visionOS)
        self.contains(.visionOS)
#endif
    }
}
