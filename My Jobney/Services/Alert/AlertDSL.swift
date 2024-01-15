//
//  AlertDSL.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/28/23.
//

import SwiftUI

/// An alert representation.
///
/// The representation contains everything needed to display an alert.
///
/// Representation is best built with ``AlertBuilder``.
struct AlertPresentation: Identifiable {
    var id = UUID()
    var title: LocalizedStringKey? = nil
    var message: String
    var actions: [AlertAction] = []
}

/// An alert action.
///
/// Essentially represents a button in an alert.
struct AlertAction: Identifiable {
    var id = UUID()
    var title: LocalizedStringKey
    var action: @Sendable () -> Void
    
    init(_ title: LocalizedStringKey, action: @escaping @Sendable () -> Void = {}) {
        self.title = title
        self.action = action
    }
}


/// A title for the alert.
///
/// Used only in ``AlertBuilder`` to distinguish between a message
/// and the alert title.
struct AlertTitle {
    var value: LocalizedStringKey
    init(_ value: LocalizedStringKey) {
        self.value = value
    }
}

/// The building block of ``AlertBuilder``.
///
/// Has no direct usage outside of ``AlertBuilder``.
enum AlertDSLComponent {
    case title(LocalizedStringKey), message(String), action(AlertAction), composite([AlertDSLComponent]), none
}

/// Alert builder providing a declarative way of defining alerts.
///
/// Processes the declarations into an ``AlertPresentation``.
@resultBuilder
struct AlertBuilder {
    static func buildExpression(_ message: String) -> AlertDSLComponent {
        .message(message)
    }

    static func buildExpression(_ title: AlertTitle) -> AlertDSLComponent {
        .title(title.value)
    }

    static func buildExpression(_ action: AlertAction) -> AlertDSLComponent {
        .action(action)
    }
    
    static func buildEither(first component: AlertDSLComponent) -> AlertDSLComponent {
        component
    }
    
    static func buildEither(second component: AlertDSLComponent) -> AlertDSLComponent {
        component
    }
    
    static func buildOptional(_ component: AlertDSLComponent?) -> AlertDSLComponent {
        component ?? .none
    }
    
    static func buildArray(_ components: [AlertDSLComponent]) -> AlertDSLComponent {
        .composite(components)
    }
    
    static func buildPartialBlock(first: AlertDSLComponent) -> AlertDSLComponent {
        first
    }
    
    static func buildPartialBlock(accumulated: AlertDSLComponent, next: AlertDSLComponent) -> AlertDSLComponent {
        switch (accumulated, next) {
        case let (.composite(accumulatedComponents), .composite(nextComponents)):
                .composite(accumulatedComponents + nextComponents)
        case let (.composite(accumulatedComponents), _):
                .composite(accumulatedComponents + [next])
        case let (_, .composite(nextComponents)):
                .composite([accumulated] + nextComponents)
        default:
                .composite([accumulated, next])
        }
    }
    
    static func buildFinalResult(_ component: AlertDSLComponent) -> AlertPresentation {
        var alert = AlertPresentation(message: "")
        
        /// Recursively applies the `component` to ``AlertPresentation``.
        func applyComponent(_ component: AlertDSLComponent) {
            switch component {
            case let .title(value):
                alert.title = value
            case let .message(value):
                alert.message = value
            case let .action(value):
                alert.actions.append(value)
            case let .composite(subComponents):
                subComponents.forEach(applyComponent)
            case .none:
                break
            }
        }
        applyComponent(component)

        return alert
    }
}

