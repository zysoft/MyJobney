//
//  ExperienceRecord.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import Foundation
import SwiftData

@Model
final class ExperienceRecord {
    var position: String
    var company: String
    var dateStarted: Date
    var dateFinished: Date?
    var content: ResumeArbitrarySection?
    
    init(position: String, company: String = "", dateStarted: Date, dateFinished: Date? = nil, content: ResumeArbitrarySection? = nil) {
        self.position = position
        self.company = company
        self.dateStarted = dateStarted
        self.dateFinished = dateFinished
        self.content = content
    }
}


// MARK: - Comparable conformance

extension ExperienceRecord: Comparable {
    static func < (lhs: ExperienceRecord, rhs: ExperienceRecord) -> Bool {
        lhs.dateFinished ?? .now > rhs.dateFinished ?? .now
    }
}


// MARK: - Copyable

extension ExperienceRecord: Copyable {
    func makeIdentical(to other: ExperienceRecord) {
        position = other.position
        company = other.company
        dateStarted = other.dateStarted
        dateFinished = other.dateFinished
        content = other.content
    }
}
