//
//  SidebarMenu.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/14/23.
//

import Foundation


enum SidebarMenu: String, Identifiable, CaseIterable {
    var id: String {
        "SidebarMenu_\(rawValue)"
    }
    case applications, resumes, coverLetters, companies, stats, myDiary
}
