//
//  JobApplication.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/11/23.
//

import Foundation
import SwiftData

@Model
final class JobApplication {
    var postingId: String
    var url: URL?
    var position: String
    var comments: String
    var salaryFrom: Double?
    var salaryTo: Double?
    var salaryPeriod: SalaryPeriod
    
    /// Documents, attached to the application.
    ///
    /// Nullify deletion rule here allows to orphan the documents which will then be picked up by ``DocumentManagementService/collectGarbage()``.
    @Relationship(deleteRule: .nullify, inverse: \FiledDocument.application)
    var documents: [FiledDocument] = []
    
    @Relationship(deleteRule: .nullify)
    var company: Company?
    
    @Relationship(deleteRule: .cascade)
    private(set) var history: [JobApplicationStatusRecord] = []
    
    /// Current application status (last in the status history).
    ///
    /// It is a String because of an issue with #Predicate - https://developer.apple.com/forums/thread/737929
    private(set) var currentStatusRaw: String = JobApplicationStatus.created.rawValue
    var currentStatus: JobApplicationStatus {
        .init(rawValue: currentStatusRaw) ?? .created
    }
    var lastUpdated: Date
    
    init(
        postingId: String = "",
        url: URL? = nil,
        position: String = "",
        comments: String = "",
        salaryFrom: Double? = nil,
        salaryTo: Double? = nil,
        salaryPeriod: SalaryPeriod = .year,
        company: Company? = nil
    ) {
        self.postingId = postingId
        self.url = url
        self.position = position
        self.comments = comments
        self.lastUpdated = .now
        self.salaryFrom = salaryFrom
        self.salaryTo = salaryTo
        self.salaryPeriod = salaryPeriod
        self.company = company
    }
    
    func addStatus(_ record: JobApplicationStatusRecord) {
        history.append(record)
        currentStatusRaw = record.status.rawValue
        lastUpdated = .now
    }
}
