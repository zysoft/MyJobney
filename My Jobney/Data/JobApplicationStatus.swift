//
//  JobApplicationStatus.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import Foundation

enum JobApplicationStatus: String, CaseIterable, Codable, Hashable, Sendable {
    case created
    case applied
    case hrCalled, interviewScheduled
    case interviewInProgress, interviewComplete
    case offerReceived, offerDeclined, offerAccepted, hired
    case notSelected, failedInterview
    case hrIssue, scam
    
    static var failedStatuses: Set<Self> {
        .init([.failedInterview, .hrIssue, .notSelected])
    }
    
}


// MARK: - Status kind - allows to classify the statuses into categories

extension JobApplicationStatus {
    enum Kind: String, Codable, Hashable, Sendable {
        case neutral, positive, negative, victory
    }
    
    var kind: Kind {
        switch self {
        case .created:
            return .neutral
        case .applied, .hrCalled , .interviewScheduled,
             .interviewInProgress, .interviewComplete,
             .offerReceived, .offerAccepted:
            return .positive
        case .offerDeclined:
            return .neutral
        case .hired:
            return .victory
        case .notSelected, .failedInterview,
             .hrIssue, .scam:
            return .negative
        }
    }
}
