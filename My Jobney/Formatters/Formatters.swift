//
//  Formatters.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/16/23.
//

import Foundation

@MainActor
class Formatters {
    static var monthAndYear: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.calendar = Calendar.current
        return dateFormatter
    }()
}
