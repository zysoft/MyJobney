//
//  ResumeFormViewVM.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/5/24.
//

import Foundation
import Observation


extension ResumeFormView {
    
    @MainActor
    @Observable class ViewModel {
        @ObservationIgnored private let storageService: StorageService

        @ObservationIgnored let resume: Resume

        var title: String {
            get { resume.title }
            set { resume.title = newValue }
        }
        var name: String {
            get { resume.name }
            set { resume.name = newValue }
        }

        var email: String {
            get { resume.email }
            set { resume.email = newValue }
        }
        var phone: String {
            get { resume.phone }
            set { resume.phone = newValue }
        }
        var location: String {
            get { resume.location }
            set { resume.location = newValue }
        }

        var summarySection: ResumeArbitrarySection
        
        init(resume: Resume?) {
            var storageService = Dependency.Service[\.storage]
            storageService.autosave = false
            self.storageService = storageService

            let resumeDocument: Resume
            if let resume = resume, let existingResume: Resume = storageService.retrieve(byId: resume.persistentModelID) {
                resumeDocument = existingResume
            } else {
                resumeDocument = .init(title: "", name: "", email: "")
                storageService.store(resumeDocument)
            }
            self.resume = resumeDocument

            summarySection = self.resume.summary ?? .init()
        }
        
        func delete(_ education: EducationRecord) {
            storageService.delete(education)
        }
        
        func save() {
            storageService.persistChanges()
        }
    }
}
