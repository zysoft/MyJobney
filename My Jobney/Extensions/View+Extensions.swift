//
//  View+Extensions.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/2/24.
//

import SwiftUI

// MARK: - Platform-dependent padding

extension View {
    /// A conditional padding which is platform dependent.
    ///
    /// Only adds the specified padding when running on one of the listed platforms.
    ///
    /// Example:
    /// ```swift
    /// struct MyView: View {
    ///     var body: some View {
    ///         Text("Test")
    ///             .padding(.vertical, 5, on: .iOS)
    ///             .padding(.vertical, 15, on: .macOS)
    ///             .padding(.horizontal, 10, on: [.macOS, .tvOS])
    ///             .background(Color.blue)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///    - edges:     The edges to pad.
    ///    - length:    The size of the padding to add.
    ///    - platforms: Platforms the padding should be applied on.
    ///
    /// - Seealso: For the list of platforms refer to ``Platforms``.
    func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil, on platforms: Platforms) -> some View {
        self
            .padding(edges, platforms.isApplicable ? length : 0)
    }
}


// MARK: - Platform-dependent frame

extension View {
    /// Positions this view within an invisible frame having the specified size constraints when running on the listed platforms.
    func frame(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil, minHeight: CGFloat? = nil, idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil, alignment: Alignment = .center, on platforms: Platforms) -> some View {
        self
            .frame(
                minWidth:    platforms.isApplicable ? minWidth    : nil,
                idealWidth:  platforms.isApplicable ? idealWidth  : nil,
                maxWidth:    platforms.isApplicable ? maxWidth    : nil,
                minHeight:   platforms.isApplicable ? minHeight   : nil,
                idealHeight: platforms.isApplicable ? idealHeight : nil,
                maxHeight:  platforms.isApplicable  ? maxHeight   : nil,
                alignment:  platforms.isApplicable  ? alignment   : .center
            )
    }
}
