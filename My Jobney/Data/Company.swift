//
//  Company.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/11/23.
//

import Foundation
import SwiftData

@Model
final class Company {
    var name: String
    var url: URL?
    var comments: String?
    
    init(name: String, url: URL? = nil, comments: String? = nil) {
        self.name = name
        self.url = url
        self.comments = comments
    }
}
