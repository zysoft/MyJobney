//
//  EducationEditViewVM.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/13/24.
//

import Foundation


extension ResumeFormView.ExperienceEditView {
    
    @MainActor
    @Observable class ViewModel {
        var experienceRecord: ExperienceRecord
        var isCurrentPosition = false
        var experienceEndDate: Date = .now
        var extraContent: ResumeArbitrarySection
        var bulletPoint = ""
        @ObservationIgnored private var originalRecord: ExperienceRecord?
        @ObservationIgnored private var resume: Resume
        
        init(experienceRecord record: ExperienceRecord? = nil, resume: Resume) {
            self.originalRecord = record
            self.resume = resume
            self.experienceRecord = .init(position: "", dateStarted: .now)
            self.extraContent = .init()
            if let record = record {
                self.experienceRecord.makeIdentical(to: record)
                if let extraContent = record.content {
                    self.extraContent = extraContent
                }
            }
        }
        
        func addBulletPoint() {
            guard bulletPoint.isNotEmpty else {
                return
            }
            extraContent.bulletPoints.append(bulletPoint)
            bulletPoint = ""
        }
        
        func delete(bulletPoint: String) {
            extraContent.bulletPoints = extraContent.bulletPoints.filter { $0 != bulletPoint }
        }
        
        func save() {
            if isCurrentPosition {
                experienceRecord.dateFinished = nil
            } else {
                experienceRecord.dateFinished = experienceEndDate
            }
            
            if extraContent.bulletPoints.isNotEmpty {
                experienceRecord.content = extraContent
            }
            
            if let original = originalRecord {
                original.makeIdentical(to: experienceRecord)
            } else {
                resume.experience.append(experienceRecord)
            }
        }
    }
}

