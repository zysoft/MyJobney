//
//  ApplicationFormViewVM.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import Foundation
import Observation

extension ApplicationFormView {
    
    @MainActor
    @Observable class ViewModel {
        @ObservationIgnored var application: JobApplication
        @ObservationIgnored private lazy var storageService = {
            var storage = Dependency.Service[\.storage]
            storage.autosave = false // Disable automatic data persisting
            return storage
        }()
        var companyName: String
        var position: String {
            get { application.position }
            set { application.position = newValue }
        }
        var salaryMin: Double? {
            get { application.salaryFrom }
            set { application.salaryFrom = newValue }
        }
        var salaryMax: Double? {
            get { application.salaryTo }
            set { application.salaryTo = newValue }
        }
        var salaryPeriod: SalaryPeriod {
            get { application.salaryPeriod }
            set { application.salaryPeriod = newValue }
        }
        var company: Company? {
            get { application.company }
            set {
                application.company = newValue
                companyName = newValue?.name ?? ""
            }
        }
        var comments: String {
            get { application.comments }
            set { application.comments = newValue }
        }
        var postingId: String {
            get { application.postingId }
            set { application.postingId = newValue }
        }
        var url: URL? {
            get { application.url }
            set { application.url = newValue }
        }
        var documents: [FiledDocument]
        
        init(application: JobApplication?) {
            self.application = application ?? .init()
            self.companyName = self.application.company?.name ?? ""
            self.documents = self.application.documents
        }
        
        func save() -> Bool {
            for document in documents {
                if nil == document.application {
                    application.documents.append(document)
                }
            }
            storageService.store(application)
            storageService.persistChanges()
            return true
        }
    }
}
