//
//  ApplicationListFilter.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/17/23.
//

import Foundation

enum ApplicationListFilter {
    case awaiting, applied, rejected, all
    
    var jobApplicationStatuses: Set<String> {
        switch self {
        case .awaiting:
            return [.created, .applied].rawSet
        case .applied:
            return [.applied].rawSet
        case .rejected:
            return JobApplicationStatus.failedStatuses.rawSet
        case .all:
            return JobApplicationStatus.allCases.rawSet
            
        }        
    }
}


// MARK: - Mapping helper

fileprivate extension Collection where Element == JobApplicationStatus {
    var rawSet: Set<String> {
        .init(map {
            $0.rawValue
        })
    }
}
