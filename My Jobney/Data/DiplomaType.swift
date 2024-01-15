//
//  DiplomaType.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import Foundation

enum DiplomaType: String, CaseIterable, Codable, Hashable, Sendable, Identifiable, LocalizedError {
    var id: String {
        "DiplomaType_\(rawValue)"
    }
    
    case undergraduate, bachelorDegree, masterDegree, phd
    
    var localizedDescription: String {
        switch self {
        case .undergraduate:
            .init(localized: "Undergraduate")
        case .bachelorDegree:
            .init(localized: "Bachelor Degree")
        case .masterDegree:
            .init(localized: "Master Degree")
        case .phd:
            .init(localized: "PhD")
        }
    }
}
