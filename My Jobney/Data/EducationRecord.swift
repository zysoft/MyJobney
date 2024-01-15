//
//  EducationRecord.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import Foundation
import SwiftData


@Model
final class EducationRecord {
    var institutionName: String
    var major: String
    var diploma: DiplomaType?
    var dateStarted: Date
    var dateFinished: Date

    init(institutionName: String, major: String, diploma: DiplomaType? = nil, dateStarted: Date, dateFinished: Date = .now) {
        self.institutionName = institutionName
        self.major = major
        self.diploma = diploma
        self.dateStarted = dateStarted
        self.dateFinished = dateFinished
    }
}


// MARK: - Comparable conformance

extension EducationRecord: Comparable {
    static func < (lhs: EducationRecord, rhs: EducationRecord) -> Bool {
        // No diploma means - "present", those should always go on top
        let lhsDate = nil == lhs.diploma ? .now : lhs.dateFinished
        let rhsDate = nil == rhs.diploma ? .now : rhs.dateFinished
        return lhsDate >= rhsDate
    }
}


// MARK: - Copyable

extension EducationRecord: Copyable {
    func makeIdentical(to other: EducationRecord) {
        institutionName = other.institutionName
        major = other.major
        diploma = other.diploma
        dateStarted = other.dateStarted
        dateFinished = other.dateFinished
    }
}
