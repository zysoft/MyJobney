//
//  JobDocumentType.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import Foundation

enum JobDocumentType: String, CaseIterable, Codable, Hashable, Sendable {
    case resume, coverLetter, other
}

extension JobDocumentType: Identifiable {
    var id: String {
        rawValue
    }
}


extension JobDocumentType {
    var localizedName: String {
        switch self {
        case .resume:
            .init(localized: "Resume")
        case .coverLetter:
            .init(localized: "Cover Letter")
        case .other:
            .init(localized: "Other")
        }
        
    }
    
}
