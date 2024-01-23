//
//  DateExtensions.swift
//  MountainAirport
//
//  Created by Gaspare Monte on 23/01/24.
//

import Foundation

extension Date {
    var dateOnly: Date {
        let cdc = Calendar.current.dateComponents([.month, .day, .year], from: self)
        return Calendar.current.date(from: cdc)!
    }
}
