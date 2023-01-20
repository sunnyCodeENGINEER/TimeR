//
//  TimeFormatting.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import Foundation

func calcTimeSince(date: Date) -> String {
    let minutesOnly = Int(date.timeIntervalSinceNow) / 60
    let hoursOnly = minutesOnly / 60
    let daysOnly = hoursOnly / 24
    
    if minutesOnly < 120 {
        return "\(minutesOnly) minutes more"
    } else if minutesOnly >= 120 && hoursOnly < 48 {
        return "\(hoursOnly) hours more"
    } else {
        return "\(daysOnly) days more"
    }
}
