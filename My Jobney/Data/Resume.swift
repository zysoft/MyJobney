//
//  Resume.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import Foundation
import OrderedCollections
import SwiftData

@Model
final class Resume {
    
    var title: String
    
    var name: String
    var email: String
    var phone: String
    var location: String
    
    var summary: ResumeArbitrarySection?
    
    @Relationship(deleteRule: .cascade)
    var education: [EducationRecord]
    
    @Relationship(deleteRule: .cascade)
    var experience: [ExperienceRecord]
    
    @Relationship(deleteRule: .cascade)
    var skills: [Skill]
    
    var additionalSections: [ResumeArbitrarySection]

    init(
        title: String,
        name: String,
        email: String,
        phone: String = "",
        location: String = "",
        summary: ResumeArbitrarySection? = nil,
        education: [EducationRecord] = [],
        experience: [ExperienceRecord] = [],
        additionalSections: [ResumeArbitrarySection] = [],
        skills: [Skill] = []
    ) {
        self.title = title
        self.name = name
        self.email = email
        self.phone = phone
        self.location = location
        self.summary = summary
        self.skills = skills
        self.education = education
        self.experience = experience
        self.additionalSections = additionalSections
    }
}
