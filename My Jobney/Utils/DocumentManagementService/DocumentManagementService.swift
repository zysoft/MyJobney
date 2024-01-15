//
//  DocumentManager.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/3/24.
//

import Foundation
import SwiftData
import Factory


protocol DocumentManagementService: Actor {
    func saveInternally(_ url: URL) async throws -> PersistentIdentifier
    func collectGarbage() async throws
}


// MARK: - Dependency Injection

extension Dependency.Service {
    var documentService: Factory<DocumentManagementService> {
        self {
            FileDocumentService()
        }
        .singleton
    }
}
