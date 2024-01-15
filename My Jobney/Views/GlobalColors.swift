//
//  GlobalColors.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/19/23.
//

import SwiftUI


extension Color {
    static func `for`(_ status: JobApplicationStatus) -> Color {
        Self.for(status.kind)
    }
    
    static func `for`(_ statusKind: JobApplicationStatus.Kind) -> Color {
        switch statusKind {
        case .negative:
            return .red
        case .neutral:
            return .gray
        case .positive:
            return .indigo
        case .victory:
            return .green
        }
    }
}
