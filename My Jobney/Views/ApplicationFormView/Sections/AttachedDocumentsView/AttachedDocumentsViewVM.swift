//
//  AttachedDocumentsViewVM.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/2/24.
//

import SwiftUI

extension ApplicationFormView.AttachedDocumentsView {
    
    @MainActor
    @Observable class ViewModel {
        @ObservationIgnored private var storageService = Dependency.Service[\.storage]
        
        init() {
        }
        
        func addDocument(from url: URL) async -> FiledDocument? {
            do {
                let _ = url.startAccessingSecurityScopedResource()
                defer {
                    url.stopAccessingSecurityScopedResource()
                }                
                let attachedId = try await Dependency.Service[\.documentService].saveInternally(url)
                return storageService.retrieve(byId: attachedId)
            } catch {
                // FIXME: Handle error
                print("Error \(error)")
            }
            return nil
        }
    }
}
