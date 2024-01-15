//
//  Date+Extensions.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/16/23.
//

import Foundation

extension Date {
    func days(since date: Date) -> Int {
        Int(timeIntervalSince(date)) / 86_400 /* 24*60*60, i.e. a day */
    }
}
