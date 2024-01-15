//
//  JobType.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import Foundation

enum JobType: String, CaseIterable, Codable, Hashable, Sendable {
    case fullTime, partTime, onCall, volunteer, temporary, internship, other
}
