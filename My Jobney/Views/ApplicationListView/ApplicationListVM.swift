//
//  ApplicationListView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/15/23.
//

import Foundation
import Observation

extension ApplicationListView {
    
    @MainActor
    @Observable class ViewModel {
        var filter: ApplicationListFilter = .awaiting
        var searchString: String = ""
        var jobApplications:[JobApplication] = []
        private let storageService = Dependency.Service[\.storage]
        
        private var searchPredicateFilter: Predicate<JobApplication> {
            let statuses = filter.jobApplicationStatuses
            return #Predicate<JobApplication> { application in
                statuses.contains(application.currentStatusRaw)
            }
        }
        
        private var searchPredicateText: Predicate<JobApplication> {
            return #Predicate<JobApplication> { application in
                application.position.localizedStandardContains(searchString) ||
                application.company?.name.localizedStandardContains(searchString) == true
            }
        }
        
        private var searchPredicate: Predicate<JobApplication> {
            searchString.isEmpty ? searchPredicateFilter : searchPredicateText
        }
        
        func refreshApplications() async {
            jobApplications = storageService.query(withPredicate: searchPredicate, orderBy: [ .init(\JobApplication.lastUpdated, order: .reverse) ])
        }
    }
    
}
