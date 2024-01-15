//
//  SalaryPeriod.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/11/23.
//

import Foundation

enum SalaryPeriod: Double, CaseIterable, Codable, Hashable, Sendable {
    case hour = 1, week = 40, month = 160, year = 2_080 /* 40h/week * 52 weeks/year */
}
