//
//  Dependencies.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/21/23.
//

import Foundation
import SwiftUI
import Factory

/// Various dependencies available to the app.
///
/// Contains a set of dependency injection containers for easier navigation.
///
/// You can use either `shared` property of the container, or you can use
/// it's static subscript to access the dependency via key path.
struct Dependency {
    /// Global dependencies, not falling into any other category.
    typealias Global = Container
    
    /// Various application services.
    final class Service: SharedContainer {
        public static let shared = Service()
         public let manager = ContainerManager()
    }
}


extension SharedContainer {
    /// Access a dependency at `keyPath` in the container.
    ///
    ///  - Parameter keyPath: Key path to the dependency.
    ///  - Returns: The dependency instance.
    ///
    ///  Example:
    ///  ```swift
    ///  let myDependency = Dependency.Service[\.myDependency]
    ///  ```
    static subscript <T>(_ keyPath: KeyPath<Self, Factory<T>>) -> T {
        shared[keyPath: keyPath]()
    }

    /// Access a dependency at `keyPath` in the container, which requires a parameter.
    ///
    ///  - Parameters:
    ///     - keyPath:   Key path to the dependency.
    ///     - parameter: Parameter to pass.
    ///  - Returns: The dependency instance.
    ///
    ///  Example:
    ///
    ///  ```swift
    ///  let myDependency = Dependency.Service[\.myDependency, parameter: 1]
    ///  ```
    static subscript <P, T>(_ keyPath: KeyPath<Self, ParameterFactory<P, T>>, parameter parameter: P) -> T {
        shared[keyPath: keyPath](parameter)
    }
}
