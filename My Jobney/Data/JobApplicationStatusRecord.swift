//
//  JobApplicationStatusRecord.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/11/23.
//

import Foundation
import SwiftData

@Model
final class JobApplicationStatusRecord {
    var status: JobApplicationStatus
    var date: Date
    
    init(status: JobApplicationStatus, date: Date = .now) {
        self.status = status
        self.date = date
    }
}
