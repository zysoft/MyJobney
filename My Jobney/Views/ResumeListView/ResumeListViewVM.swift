//
//  ResumeListViewVM.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/5/24.
//

import Foundation
import Observation

extension ResumeListView {
    
    @MainActor
    @Observable class ViewModel {
        var resumes:[Resume] = []
        private let storageService = Dependency.Service[\.storage]
        
        
        func refreshResumes() async {
            resumes = storageService.query(orderBy: [ .init(\Resume.title, order: .reverse) ])
        }
    }
    
}
