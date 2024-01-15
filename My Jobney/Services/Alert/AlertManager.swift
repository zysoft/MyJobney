//
//  AlertManager.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/26/23.
//

import SwiftUI
import Factory


/// A manager showing the alerts.
///
/// It provides ``isAlertPresented`` property indicating when an alert is present,
/// as well as ``presentedAlert`` which is the ``AlertPresentation`` being displayed.
@MainActor
protocol AlertManager: AnyObject {
    var presentedAlert: AlertPresentation? { get set }
}

extension AlertManager {
    /// Presents an alert.
    /// - Parameter alert: Alert to present.
    func present(_ alert: AlertPresentation) {
        presentedAlert = alert
    }
    /// Presents an alert constructed by ``AlertBuilder``.
    func present(@AlertBuilder _ builder: () -> AlertPresentation) {
        presentedAlert = builder()
    }
}

fileprivate extension AlertManager {
    /// A binding indicating that an alert is displayed.
    ///
    /// Can (and should) be directly passed to SwiftUI.
    var isAlertPresented: Binding<Bool> {
        .init { [weak self] in
            nil != self?.presentedAlert
        } set: { [weak self] _ in
            self?.presentedAlert = nil
        }
    }
}

// MARK: - ViewModifier

/// A view modifier needed to attach an ``AlertManager`` to a view.
///
/// - Seealso: ``SwiftUI/View/managerAlerts``
private struct AlertManagerAttachmentModifier<Manager>: ViewModifier where Manager: AlertManager {
    var manager: Manager
    func body(content: Content) -> some View {
        content
            .alert(manager.presentedAlert?.title ?? "", isPresented: manager.isAlertPresented, presenting: manager.presentedAlert) { presentation in
                ForEach(presentation.actions) { button in
                    Button(button.title, action: button.action)
                }
            } message: { presentation in
                Text(presentation.message)
            }
    }
}

extension View {
    /// A view modifier needed to attach an ``AlertManager`` to a view.
    ///
    /// An example:
    /// ```swift
    /// struct MyView: View {
    ///     @State private var alertManager = MyAlertManager()
    ///     var body: some View {
    ///         Button("Press me") {
    ///             alertManager.present {
    ///                 AlertTitle("Hello there")
    ///                 "This is a sample alert"
    ///                 AlertAction("I understand")
    ///             }
    ///         }
    ///         .manageAlerts(with: alertManager)
    ///     }
    /// }
    /// ```
    func manageAlerts(with manager: some AlertManager) -> some View {
        self
            .modifier(AlertManagerAttachmentModifier(manager: manager))
    }
}


// MARK: - Dependency Injection

extension Dependency.Service {
    /// A concrete implementation of the ``AlertManager``.
    ///
    /// - Seealso: ``DefaultAlertManager`` - the default implementation used in the app.
    @MainActor
    var alertManager: Factory<some AlertManager> {
        self {
            DefaultAlertManager()
        }
    }
}

