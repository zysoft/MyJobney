//
//  FiledDocument.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/12/23.
//

import Foundation
import SwiftData

@Model
final class FiledDocument {
    var name: String
    var url: URL
    var application: JobApplication?
    
    init(name: String, url: URL, attachTo application: JobApplication? = nil) {
        self.name = name
        self.url = url
        self.application = application
    }
}
