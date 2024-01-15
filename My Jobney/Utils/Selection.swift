//
//  Selection.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/13/24.
//

import Foundation

/// Represents a selection.
///
/// It can carry some ``item`` that is selected, or it could
/// be set to `nil`to to signal the consuming code to interpret it
/// based on context.
struct Selection<T>: Identifiable {
    /// Selection identifier.
    ///
    /// The selection os expected to stored in a `@State` variable, and
    /// primarily used to display an item in sheets.
    ///
    /// ** The identifier is not stable**, but enough for the use case.
    var id = UUID()
    
    /// The item selected.
    var item: T?
}
