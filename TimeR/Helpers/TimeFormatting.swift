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
    
    if minutesOnly >= -120 && hoursOnly < 48 {
        return "\(hoursOnly) hours ago"
    }
    else if minutesOnly < 0 {
        return "\(minutesOnly) minutes ago"
    }
    else if minutesOnly < 120 {
        return "\(minutesOnly) minutes more"
    } else if minutesOnly >= 120 && hoursOnly < 48 {
        return "\(hoursOnly) hours more"
    } else {
        return "\(daysOnly) days more"
    }
}

func systemCalcTimeSince(date: Date) -> String {
    let minutesOnly = Int(date.timeIntervalSinceNow) / 60
    let hoursOnly = minutesOnly / 60
    let daysOnly = hoursOnly / 24
    
    if minutesOnly < 120 {
        return "\(minutesOnly)"
    } else if minutesOnly >= 120 && hoursOnly < 48 {
        return "\(hoursOnly)"
    } else {
        return "\(daysOnly)"
    }
}

func systemCalcTimeSince2(date: Date) -> String {
    let minutesOnly = Int(date.timeIntervalSinceNow) / 60
    
    return "\(minutesOnly)"
   
}
