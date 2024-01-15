//
//  FileDocumentService.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/4/24.
//

import Foundation
import SwiftData
import OSLog

final actor FileDocumentService: DocumentManagementService {
    private lazy var logger: Logger = {
        .init(subsystem: Bundle.main.bundleIdentifier ?? "", category: #file)
    }()
    private lazy var storageService: StorageService = {
        Dependency.Service[\.storage]
    }()

    /// Documents directory (within the sandbox).
    private lazy var documentsUrl: URL = {
        .documentsDirectory
    }()
    
    /// Directory where the job application attachments are stored (within `documentsUrl`.
    private lazy var jobApplicationFilesUrl: URL = {
        let directory = documentsUrl.appendingPathComponent("JobDocuments", conformingTo: .directory)
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        } catch {
            return documentsUrl
        }
        return directory
    }()

    /// Saves the file at the given URL for internal use.
    ///
    /// Saves the copy of the file to the sandboxed storage.
    ///
    /// The file url has to be properly selected by used to allow access to the file.
    ///
    /// - Parameters:
    ///    - url: URL of the file to store.
    /// - Returns: URL to the file in the internal storage.
    func saveInternally(_ url: URL) async throws -> PersistentIdentifier {
        let docUrl = makeInternalUrl(forJobApplicationAttachment: url)
        try FileManager.default.copyItem(at: url, to: docUrl)
        let model = FiledDocument(name: url.lastPathComponent, url: docUrl)
        storageService.store(model)
        return model.persistentModelID
    }
    
    /// Removes the orphaned files.
    func collectGarbage() async throws {
        let predicate = #Predicate<FiledDocument> { $0.application == nil }
        let orphanedFiles = storageService.query(withPredicate: predicate)
        guard orphanedFiles.isNotEmpty else {
            return // Nothing to do
        }
        orphanedFiles.forEach {
            logger.trace("Removing \($0.name) from \($0.url)")
            // FIXME: Can we do anything or just keep going?
            try? FileManager.default.removeItem(at: $0.url)
        }
        storageService.delete(orphanedFiles)
        logger.debug("Removed \(orphanedFiles.count) orphaned files")
    }
    
    private func makeInternalUrl(forJobApplicationAttachment attachment: URL) -> URL {
        jobApplicationFilesUrl
            .appending(path: UUID().uuidString)
            .appendingPathExtension(attachment.pathExtension)
    }
}
