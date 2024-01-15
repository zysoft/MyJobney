//
//  Copyable.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/13/24.
//

import Foundation

/// Protocol allowing to make two instances identical by copying internals.
protocol Copyable {
    /// Making self identical to the provided instance.
    ///
    /// - Parameters:
    ///    - other: Object to make self identical to.
    func makeIdentical(to other: Self)
}
