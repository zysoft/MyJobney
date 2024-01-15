//
//  Skill.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import Foundation
import SwiftData

@Model
final class Skill {
    var title: String
    var yearsOfExperience: Int
    
    init(title: String, yearsOfExperience: Int) {
        self.title = title
        self.yearsOfExperience = yearsOfExperience
    }
}

// MARK: - Comparable conformance

extension Skill: Comparable {
    static func < (lhs: Skill, rhs: Skill) -> Bool {
        lhs.yearsOfExperience > rhs.yearsOfExperience
    }
}
