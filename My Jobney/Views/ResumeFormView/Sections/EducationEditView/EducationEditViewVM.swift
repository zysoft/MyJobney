//
//  EducationEditViewVM.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/13/24.
//

import Foundation
import Observation

extension ResumeFormView.EducationEditView {
    
    @MainActor
    @Observable class ViewModel {
        var educationRecord: EducationRecord
        @ObservationIgnored private var originalRecord: EducationRecord?
        @ObservationIgnored private var resume: Resume
        
        init(educationRecord record: EducationRecord? = nil, resume: Resume) {
            self.originalRecord = record
            self.resume = resume
            self.educationRecord = .init(institutionName: "", major: "", dateStarted: .now)
            if let record = record {
                self.educationRecord.makeIdentical(to: record)
            }
        }
        
        func save() {
            if let original = originalRecord {
                original.makeIdentical(to: educationRecord)
            } else {
                resume.education.append(educationRecord)
            }
        }
    }
}

